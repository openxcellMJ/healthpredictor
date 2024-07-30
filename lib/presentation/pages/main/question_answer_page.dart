import 'package:envitely/presentation/controller/main/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../custom_widgets/app_widgets.dart';
import '../../../domain/entities/ChatModels.dart';
import '../../../utils/utils.dart';
import '../../../values/app_colors.dart';
import '../../../values/app_images.dart';
import '../../../values/strings_name.dart';

class QuestionAnswerPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppWidgets.appBar(true, title: ' Q & A'),
          body: Column(children: [
            Expanded(
              child: Obx(
                () => controller.chats.isEmpty
                    ? Center(
                        child: Image.asset(
                          AppImage.icEmptyChat,
                          height: 200,
                          width: 200,
                        ),
                      )
                    : Obx(
                        () => ListView.builder(
                          controller: controller.scrollController,
                          itemCount: controller.chats.length + 1,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          // physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return index == controller.chats.length
                                ? controller.isBotTyping.value == false
                                    ? Container()
                                    : Container(
                                        padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              padding: const EdgeInsets.all(16),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    AppImage.icBotTyping,
                                                    height: 40,
                                                    fit: BoxFit.fill,
                                                    width: 100,
                                                  ),
                                                ],
                                              )),
                                        ),
                                      )
                                : Container(
                                    padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                                    child: Align(
                                      alignment: (controller.chats[index].owner == StringNames.BOT ? Alignment.topLeft : Alignment.topRight),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: (controller.chats[index].owner == StringNames.BOT ? AppColors.gradientMiddle.withOpacity(0.6) : Colors.grey.shade200),
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          controller.chats[index].text,
                                          style: Get.textTheme.displayMedium?.copyWith(
                                            fontSize: 15,
                                            color: (controller.chats[index].owner == StringNames.BOT ? AppColors.colorWhite : AppColors.blackFontSubTitle),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller.chatController,
                      keyboardType: TextInputType.multiline,
                      style: Get.theme.textTheme.bodySmall?.copyWith(color: AppColors.blackFontTitle, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: Get.theme.textTheme.bodySmall?.copyWith(fontSize: 14, color: AppColors.hintText),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: Get.theme.elevatedButtonTheme.style?.copyWith(shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))), backgroundColor: const MaterialStatePropertyAll(AppColors.gradientMiddle)),
                    onPressed: () {
                      Utils.hideKeyboard();
                      addMyMessage();
                    },
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }

  void addMyMessage() {
    if (controller.chatController.text.trim().isNotEmpty) {
      controller.chats.add(ChatModels(text: controller.chatController.text, owner: StringNames.YOU, dateTime: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())));
      controller.chats.refresh();
      askQuestionToBot(controller.chatController.text);
      controller.chatController.clear();
      controller.changeStatus(true);
    }
  }

  void askQuestionToBot(String question) {
    controller.isBotTyping.value = true;
    controller.callQuestionAnswerData(controller.chatController.text);
    //call api
  }

  void addBotMessage(String reply) {
    if (controller.isListen.value == true) {
      controller.chats.add(ChatModels(text: reply, owner: StringNames.BOT, dateTime: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())));
      controller.chats.refresh();
      controller.isBotTyping.value = false;
      controller.changeStatus(false);
    }
  }
}
