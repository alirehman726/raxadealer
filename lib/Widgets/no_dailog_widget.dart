import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color1.dart';

noDataWidget(String title, context, onPressed) {
  return Container(
    width: Get.width,
    height: Get.height * 0.4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: primaryColor,
          ),
          child: IconButton(
            splashColor: primaryColor,
            icon: Icon(Icons.refresh, color: white),
            tooltip: 'Refresh',
            onPressed: onPressed,
          ),
          // .backgroundColor(primaryColor).cornerRadius(50)
        )
      ],
    ),
  );
}
