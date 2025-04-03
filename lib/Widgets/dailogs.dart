import 'package:raxaadmin/Widgets/text_styles.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

logoutDialog() {
  Get.dialog(
    AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('🎉 Success '),
          const SizedBox(height: 20),
          Text(
            'Just set a reminder like a boss!',
            style: TextStyle(
              color: Color(0xff3C3C43),
              fontFamily: "Roboto",
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            "Don't forget to share our application to your colleagues & friends.",
            style: TextStyle(
              color: Color(0xff3C3C43),
              fontFamily: "Roboto",
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'OK',
            style: TextStyle(
              color: Color(0xff5856D6),
              fontFamily: "Roboto",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Get.back();
          },
        )
      ],
    ),
    barrierDismissible: false,
  );
}

class DialogCustom {
  /// Success Dialog
  static success(String title, String message) {
    Get.dialog(
      AlertDialog(
        icon: Icon(Icons.check_circle_outlined,
            size: 40.r, color: darkGreenColor),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: CustomTextStyles.primaryTextStyle(
                  fontSize: 15.sp, color: darkGreenColor),
            ),
            SizedBox(height: 10.h),
            Text(
              message,
              style: CustomTextStyles.primaryTextStyle(
                  fontSize: 12.sp, color: Colors.black.withOpacity(0.5)),
            )
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              'OK',
              style: CustomTextStyles.primaryTextStyle(
                  color: primaryColor, fontSize: 14.sp),
            ),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  /// Warning Dialog
  static warning(String title, String message) {
    Get.dialog(
      AlertDialog(
        icon: Icon(Icons.warning_amber_rounded,
            size: 40.r, color: darkWarningColor),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: CustomTextStyles.primaryTextStyle(
                  fontSize: 15.sp, color: darkWarningColor),
            ),
            SizedBox(height: 10.h),
            Text(
              message,
              style: CustomTextStyles.primaryTextStyle(
                  fontSize: 12.sp, color: Colors.black.withOpacity(0.5)),
            )
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              'OK',
              style: CustomTextStyles.primaryTextStyle(
                  color: primaryColor, fontSize: 14.sp),
            ),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  /// Danger Dialog
  static danger(String title, String message) {
    Get.dialog(
      AlertDialog(
        icon: Icon(Icons.dangerous_outlined, size: 40.r, color: darkRedColor),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: CustomTextStyles.primaryTextStyle(
                  fontSize: 15.sp, color: darkRedColor),
            ),
            SizedBox(height: 10.h),
            Text(
              message,
              style: CustomTextStyles.primaryTextStyle(
                  fontSize: 12.sp, color: Colors.black.withOpacity(0.5)),
            )
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              'OK',
              style: CustomTextStyles.primaryTextStyle(
                  color: primaryColor, fontSize: 14.sp),
            ),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  /// Confirm Delete Dialog
  static confirmDelete(String title, String message) {
    return Get.dialog(
      AlertDialog(
        icon: Icon(Icons.delete_outline_rounded,
            size: 40.r, color: darkWarningColor),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: CustomTextStyles.primaryTextStyle(
                  fontSize: 15.sp, color: darkWarningColor),
            ),
            SizedBox(height: 10.h),
            Text(
              message,
              style: CustomTextStyles.primaryTextStyle(
                  fontSize: 12.sp, color: Colors.black.withOpacity(0.5)),
            )
          ],
        ),
        actions: [
          TextButton(
              child: Text(
                'Yes',
                style: CustomTextStyles.primaryTextStyle(
                    color: primaryColor, fontSize: 14.sp),
              ),
              onPressed: () {
                Get.back(result: 'yes');
              }),
          TextButton(
              child: Text(
                'No',
                style: CustomTextStyles.primaryTextStyle(
                    color: Colors.grey, fontSize: 14.sp),
              ),
              onPressed: () {
                Get.back(result: 'no');
              }),
        ],
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }
}
