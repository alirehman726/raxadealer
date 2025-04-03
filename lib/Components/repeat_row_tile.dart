import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';
import 'package:raxaadmin/utils/color.dart';

class RepeatRowTile extends StatefulWidget {
  final String repeatEveryLabel;
  final String tileLabel;
  final String tileImage;
  final void Function() onClick;

  const RepeatRowTile(
      {Key? key,
      required this.tileLabel,
      required this.tileImage,
      required this.repeatEveryLabel,
      required this.onClick})
      : super(key: key);

  @override
  State<RepeatRowTile> createState() => _RepeatRowTileState();
}

class _RepeatRowTileState extends State<RepeatRowTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.r,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: whiteBgColor,
        border: Border.all(color: whiteBgColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  widget.tileImage,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  widget.tileLabel,
                  style: CustomTextStyles.primaryTextStyle(
                      color: Colors.black, fontSize: 16.sp),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.repeatEveryLabel,
                  style: CustomTextStyles.primaryTextStyle(
                      color: grayTextColor, fontSize: 14.sp),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 24.r,
                  color: Colors.black,
                )
              ],
            ),
          ],
        ),
        onTap: widget.onClick,
      ),
    );
  }
}
