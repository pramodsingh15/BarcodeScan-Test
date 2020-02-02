import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Utility {
  // static ProgressDialog progressDialog;

  // static startProgressDialog(BuildContext context) {
  //   progressDialog = new ProgressDialog(context);
  //   progressDialog.style(message: 'Please wait...');
  //   progressDialog.show();
  // }

  // static closeProgressDialog() {
  //   if (progressDialog != null) {
  //     progressDialog.dismiss();
  //   }
  // }

  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static showToastMsg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.blueAccent,
        fontSize: 16.0,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }

  static Widget getText(String title, double fontSize) {
    return Text(
      title,
      // style: TextStyle(fontFamily: AppStrings.SEGOEUI_FONT, fontSize: fontSize,fontWeight: FontWeight.w400),

    );
  }
}
