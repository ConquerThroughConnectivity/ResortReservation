/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key key,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.iconData,
    this.labelText,
    this.obscureText,
    this.suffixIcon,
    this.isFirst,
    this.isLast,
    this.style,
    this.textAlign,
    this.suffix, this.countryCode,
  }) : super(key: key);

  final FormFieldSetter<String> onSaved;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final String initialValue;
  final String hintText;
  final String errorText;
  final TextAlign textAlign;
  final String labelText;
  final TextStyle style;
  final IconData iconData;
  final bool obscureText;
  final bool isFirst;
  final bool isLast;
  final Widget suffixIcon;
  final Widget suffix;
  final Widget countryCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 14, left: 20, right: 20),
      margin: EdgeInsets.only(left: 20, right: 20, top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: buildBorderRadius,
          boxShadow: [
            BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            labelText ?? "",
            style: Get.textTheme.bodyText1,
            textAlign: textAlign ?? TextAlign.start,
          ),
          labelText.contains("Phone") ?
          Row(
            children: <Widget>[
              Expanded(child: countryCode,),
              Expanded(child:  TextFormField(
                enabled:  labelText.contains("Resortname")|| labelText.contains("Resort Fee") ? false :true,
                maxLines: keyboardType == TextInputType.multiline ? null : 1,
                key: key,
                keyboardType: labelText.contains("Phone") ?TextInputType.number :TextInputType.text,
                maxLength: 10,
                onSaved: onSaved,
                onChanged: onChanged,
                validator: validator,
                initialValue: initialValue ?? '', 
                style: style ?? Get.textTheme.bodyText2,
                obscureText: obscureText ?? false,
                textAlign: textAlign ?? TextAlign.start,
                decoration: getInputDecoration(
                  hintText: hintText ?? '',
                  suffixIcon: suffixIcon,
                  suffix: suffix,
                  errorText: errorText,
                ),
           ),)
            ],
          ):labelText.contains("OTP") ?TextFormField(
            enabled:  labelText.contains("Resortname") || labelText.contains("Resort Fee")? false :true,
                
                maxLines: keyboardType == TextInputType.multiline ? null : 1,
                key: key,
                keyboardType: labelText.contains("Resort Fee") ||labelText.contains("OTP") ?TextInputType.number :TextInputType.text,
                onSaved: onSaved,
                onChanged: onChanged,
                maxLength: 6,
                validator: validator,
                initialValue: initialValue ?? '',
                style: style ?? Get.textTheme.bodyText2,
                obscureText: obscureText ?? false,
                textAlign: textAlign ?? TextAlign.start,
                decoration: getInputDecoration(
                  hintText: hintText ?? '',
                  suffixIcon: suffixIcon,
                  suffix: suffix,
                  errorText: errorText,
                ),
           ):TextFormField(
                enabled:  labelText.contains("Resortname") || labelText.contains("Resort Fee")? false :true,
                maxLines: keyboardType == TextInputType.multiline ? null : 1,
                key: key,
                keyboardType: labelText.contains("Email")  ?TextInputType.emailAddress : labelText.contains("Resort Fee") ? TextInputType.number :TextInputType.text,
                onSaved: onSaved,
                onChanged: onChanged,
                validator: validator,
                initialValue: initialValue ?? '',
                style: style ?? Get.textTheme.bodyText2,
                obscureText: obscureText ?? false,
                textAlign: textAlign ?? TextAlign.start,
                decoration: getInputDecoration(
                  hintText: hintText ?? '',
                  suffixIcon: suffixIcon,
                  suffix: suffix,
                  errorText: errorText,
                ),
           ),
        ],
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst != null && isFirst) {
      return BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast != null && isLast) {
      return BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (isFirst != null && !isFirst && isLast != null && !isLast) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst != null && isFirst)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast != null && isLast)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
  static InputDecoration getInputDecoration({String hintText = '', String errorText, IconData iconData, Widget suffixIcon, Widget suffix}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Get.textTheme.caption,
      prefixIcon: iconData != null ? Icon(iconData, color: Get.theme.focusColor).marginOnly(right: 14) : SizedBox(),
      prefixIconConstraints: iconData != null ? BoxConstraints.expand(width: 38, height: 38) : BoxConstraints.expand(width: 0, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.all(0),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }
}
