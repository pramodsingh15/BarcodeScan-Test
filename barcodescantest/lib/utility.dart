import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility {
  static showToastMsg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.blueAccent,
        fontSize: 16.0,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }
}
