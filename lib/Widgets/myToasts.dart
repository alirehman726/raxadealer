import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';
import 'package:raxaadmin/utils/color.dart';

longToastMessage(String msg) {
  Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
}

errorToast(BuildContext context, String message) {
  final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message,
                style: CustomTextStyles.primaryTextStyle(
                    color: Colors.white, fontSize: 14.0)),
          )
        ],
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

successToast(BuildContext context, String message) {
  final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message,
                style: CustomTextStyles.primaryTextStyle(
                    color: Colors.white, fontSize: 14.0)),
          )
        ],
      ),
      backgroundColor: primaryColor,
      duration: const Duration(seconds: 3));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

warningToast(BuildContext context, String message) {
  final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.warning_amber_outlined,
            color: Colors.black,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message,
                style: CustomTextStyles.primaryTextStyle(
                    color: Colors.black, fontSize: 14.0)),
          )
        ],
      ),
      backgroundColor: Colors.yellow,
      duration: const Duration(seconds: 3));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class SnackbarCustom {
  static success(String title, String message) {
    Get.snackbar(title, message,
        icon: Icon(Icons.check_circle_outline, color: Colors.white, size: 24.r),
        backgroundColor: darkGreenColor,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 600),
        borderRadius: 8.r,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(20.r),
        boxShadows: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 4))
        ]);
  }

  static warning(String title, String message) {
    Get.snackbar(title, message,
        icon:
            Icon(Icons.warning_amber_outlined, color: Colors.black, size: 24.r),
        backgroundColor: darkWarningColor,
        colorText: Colors.black,
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 600),
        borderRadius: 8.r,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(20.r),
        boxShadows: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 4))
        ]);
  }

  static error(String title, String message) {
    Get.snackbar(title, message,
        icon: Icon(Icons.error_outline, color: Colors.white, size: 24.r),
        backgroundColor: darkRedColor,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 600),
        borderRadius: 8.r,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(20.r),
        boxShadows: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 4))
        ]);
  }
}
