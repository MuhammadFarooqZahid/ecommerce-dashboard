import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage({
  required String message,
  Color backgroundColor = Colors.black,
}) {
  Fluttertoast.showToast(
    msg: message,
    // backgroundColor: backgroundColor,
    webBgColor: backgroundColor,
    gravity: ToastGravity.BOTTOM,
    webShowClose: true,
  );
}
