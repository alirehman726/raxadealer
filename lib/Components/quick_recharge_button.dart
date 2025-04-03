import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';

import '../utils/color.dart';

class QuickRechargeButton extends StatefulWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color selectedBackgroundColor;
  bool? isSelected = false;
  final int credit;
  final int amount;
  final int itemIndex;
  final void Function(int) onClick;

  QuickRechargeButton({
    Key? key,
    required this.width,
    required this.height,
    this.backgroundColor = Colors.red,
    this.selectedBackgroundColor = Colors.green,
    required this.credit,
    required this.amount,
    this.isSelected,
    required this.itemIndex,
    required this.onClick,
  }) : super(key: key);

  @override
  State<QuickRechargeButton> createState() => _QuickRechargeState();
}

class _QuickRechargeState extends State<QuickRechargeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onClick(widget.itemIndex);
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        margin: EdgeInsets.only(right: 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: (widget.isSelected == true)
                        ? widget.selectedBackgroundColor.withAlpha(15)
                        : widget.backgroundColor.withAlpha(15),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.r),
                        topRight: Radius.circular(15.r))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.credit}",
                        style: CustomTextStyles.primaryTextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Hellory Credits",
                        style: CustomTextStyles.primaryTextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 35.h,
              decoration: BoxDecoration(
                  color: (widget.isSelected == true)
                      ? widget.selectedBackgroundColor
                      : primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r))),
              child: Center(
                child: Text(
                  "₹${widget.amount}",
                  style: CustomTextStyles.primaryTextStyle(
                      color: Colors.white, fontSize: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
