

import 'package:envitely/values/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(double fontSize,String fontFamily,FontWeight fontWeight,Color textColor)
{
  return TextStyle(fontSize: fontSize,fontFamily: fontFamily,color: textColor,fontWeight: fontWeight);
}

TextStyle? getRegularStyle({double fontSize = FontSize.s12,required Color fontColor})
{
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.regular, fontColor);
}

TextStyle getBoldStyle({double fontSize = FontSize.s12,required Color fontColor})
{
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.bold, fontColor);
}

TextStyle getMediumStyle({double fontSize = FontSize.s12,required Color fontColor})
{
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.medium, fontColor);
}

TextStyle getSemiBoldStyle({double fontSize = FontSize.s12,required Color fontColor})
{
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.semiBold, fontColor);
}

TextStyle getLightStyle({double fontSize = FontSize.s12,required Color fontColor})
{
  return _getTextStyle(fontSize, FontConstants.fontFamily, FontWeightManager.light, fontColor);
}