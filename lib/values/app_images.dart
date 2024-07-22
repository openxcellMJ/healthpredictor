import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImage {
  static String commanName = "assets/images";

  static String icLogo = "$commanName/ic_logo.png";
  static String icFromFill = "$commanName/ic_fill_form.png";
  static String icUploadImage = "$commanName/ic_upload_image.png";
  static String icCross = "$commanName/ic_cross.svg";
  static String icAppLoader = "$commanName/ic_loader.json";
  static String icRight = "$commanName/ic_right.svg";
  static String icArrowBack = "$commanName/ic_arrow_back.svg";
  static String icEmptyChat = "$commanName/empty_chat.gif";
  static String icBotTyping = "$commanName/bot_typing.gif";

  static Widget loadSVG(String image, {double width = double.maxFinite, double height = double.maxFinite, BoxFit fit = BoxFit.contain, double radius = 0, Color? color}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SvgPicture.asset(
        image,
        width: width,
        fit: fit,
        height: height,
        color: color,
      ),
    );
  }

  static Widget loadPNG(String image, {double width = double.maxFinite, double height = double.maxFinite, BoxFit fit = BoxFit.contain, double radius = 0, Color? color}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        image,
        width: width,
        fit: fit,
        height: height,
        color: color,
      ),
    );
  }

  static Widget loadSVGs(String image, {double width = 50, double height = 50, Color? tintColor}) {
    return SvgPicture.asset(
      image,
      width: width,
      height: height,
      color: tintColor,
    );
  }

  static Widget loadCacheNetworkImage(String image, {double width = 30, double height = 30}) {
    return CachedNetworkImage(
      imageUrl: image,
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
          ),
        ),
      ),
      errorWidget: (context, url, error) => AppImage.loadSVGs(AppImage.icLogo),
      placeholder: (context, url) {
        return AppImage.loadSVGs(AppImage.icLogo);
      },
    );
  }

  static Widget loadSVGsWithcolor(String image, {double width = 50, double height = 50, Color? colorBottom}) {
    return SvgPicture.asset(
      image,
      width: width,
      height: height,
      color: colorBottom,
    );
  }

  static Widget load(String image, {double width = double.maxFinite, double height = double.maxFinite, BoxFit fit = BoxFit.contain, double radius = 0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        image,
        width: width,
        fit: fit,
        height: height,
      ),
    );
  }
}
