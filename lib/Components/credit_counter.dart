import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';

import '../utils/images.dart';

class CreditCounter extends StatefulWidget {
  final Color backgroundColor;
  final double width;
  final double height;
  final EdgeInsets contentPadding;
  final BorderRadius borderRadius;
  final String title;
  final String counter;

  const CreditCounter({
    Key? key,
    required this.backgroundColor,
    required this.width,
    required this.height,
    required this.contentPadding,
    required this.borderRadius,
    required this.title,
    required this.counter,
  }) : super(key: key);

  @override
  State<CreditCounter> createState() => _CreditCounterState();
}

class _CreditCounterState extends State<CreditCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.contentPadding,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
        ),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Image.asset(
                Images.LINE2,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: CustomTextStyles.primaryTextStyle(
                        color: Colors.white, fontSize: 14.sp),
                  ),
                  Text(
                    widget.counter,
                    style: CustomTextStyles.primaryTextStyle(
                        color: Colors.white,
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10.h,
              right: 10.h,
              child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Image.asset(
                  Images.LOGO2,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
