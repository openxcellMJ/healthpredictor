import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../values/app_colors.dart';
import '../values/strings_name.dart';

// ignore: must_be_immutable
class CustomEditText extends StatefulWidget {
  final bool enabled;
  final bool readOnly;
  final String? errorText;
  String hintText;
  final double topValue;
  final Alignment alignment;
  final TextInputType type;
  final TextInputAction textInputAction;
  bool obscure;
  TextEditingController? controller = TextEditingController();
  final int maxLength;
  final int maxLines;
  final int minLines;
  final bool isPassword;
  final bool isIconNeed;
  String prefixIcon;

  //final Function(String)? onChanges;
  final String fieldType;
  final TextAlign align;
  String? value = "";

  //final TextStyle style;
  CustomEditText(
      {super.key,
      this.align = TextAlign.start,
      // this.onChanges,
      this.errorText,
      this.hintText = "",
      this.alignment = Alignment.topLeft,
      this.topValue = 8.0,
      required this.type,
      required this.textInputAction,
      this.obscure = false,
      this.controller,
      this.value,
      this.enabled = true,
      this.readOnly = false,
      this.isPassword = false,
      this.isIconNeed = false,
      this.maxLength = 50,
      this.maxLines = 1,
      this.minLines = 1,
      this.prefixIcon = "",
      this.fieldType = "normal"});

  @override
  State<CustomEditText> createState() => _CustomState();
}

class _CustomState extends State<CustomEditText> {
  @override
  Widget build(BuildContext context) {
    if (widget.controller == null) {
      widget.controller?.text = widget.value ?? "";
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      margin: EdgeInsets.only(left: 0, right: 0, top: widget.topValue),
      alignment: widget.alignment,
      child: TextFormField(
        keyboardType: widget.type,
        textInputAction: widget.textInputAction,
        obscureText: widget.obscure,
        obscuringCharacter: '*',
        controller: widget.controller,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines,
        textAlign: widget.align,
        cursorColor: AppColors.blackFont,
        inputFormatters: getInputFormatterBasedOnType(widget.fieldType),
        //onChanged: widget.onChanges,
        minLines: widget.minLines,
        style: Get.theme.textTheme.bodySmall?.copyWith(color: AppColors.blackFontTitle, fontSize: 14.sp),
        decoration: InputDecoration(
          fillColor: widget.enabled ? Colors.white : AppColors.disableButtonBackground,
          filled: true,
          errorMaxLines: 3,
          labelText: widget.hintText,
          border: const OutlineInputBorder(),
          // hintText: widget.hintText,
          hintStyle: Get.theme.textTheme.bodySmall?.copyWith(fontSize: 14.sp, color: AppColors.hintText),
          //errorText: widget.errorText ,
          //prefixIcon: widget.errorText != null ? Icon(Icons.add):null
        ),
      ),
    );
  }

  List<TextInputFormatter> getInputFormatterBasedOnType(String fieldType) {
    if (fieldType == StringNames.normalField) {
      return [
        LengthLimitingTextInputFormatter(widget.maxLength),
        FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
        NoLeadingSpaceFormatter(),
      ];
    } else if (fieldType == StringNames.phoneField) {
      return [
        LengthLimitingTextInputFormatter(widget.maxLength),
        FilteringTextInputFormatter.digitsOnly // for mobile
      ];
    } else if (fieldType == StringNames.emailField || fieldType == StringNames.passwordField) {
      return [
        LengthLimitingTextInputFormatter(widget.maxLength),
        NoLeadingSpaceFormatter(),
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ];
    } else if (fieldType == StringNames.regularField) {
      return [
        NoLeadingSpaceFormatter(),
        LengthLimitingTextInputFormatter(widget.maxLength),
      ];
    } else if (fieldType == StringNames.onlyDecimalField) {
      return [
        NoLeadingSpaceFormatter(),
        LengthLimitingTextInputFormatter(widget.maxLength),
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))];
    } else {
      return [
        LengthLimitingTextInputFormatter(widget.maxLength),
      ];
    }
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();
      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }
    return newValue;
  }

//   decoration: InputDecoration(
//             filled: true,
//             fillColor: AppColors.lightGray,
//             suffixIcon: widget.isPassword
//                 ? Focus(
//                     descendantsAreFocusable: false,
//                     canRequestFocus: false,
//                     child: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           widget.obscure = !widget.obscure;
//                         });
//                       },
//                       icon: Icon(
//                         widget.obscure ? Icons.visibility : Icons.visibility_off,
//                         color: AppColors.grey,
//                       ),
//                     ),
//                   )
//                 : null,
//             prefixIcon: widget.isIconNeed
//                 ? Focus(
//                     descendantsAreFocusable: false,
//                     canRequestFocus: false,
//                     child: Image(
//                       image: AssetImage(widget.prefixIcon),
//                       width: 14,
//                     ))
//                 : null,
//             errorText: widget.errorText,
//             hintText: widget.hintText,
//             floatingLabelBehavior: FloatingLabelBehavior.always),
}
