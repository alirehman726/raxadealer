import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';
import 'package:raxaadmin/utils/color.dart';

class RowTileLight extends StatefulWidget {
  final IconData prefixIcon;
  final Color prefixIconColor;
  final IconData suffixIcon;
  final Color suffixIconColor;
  final String label;
  final double fontSize;
  final Color fontColor;
  final bool dividerRequired;
  final void Function()? onClick;

  const RowTileLight(
      {Key? key,
      required this.prefixIcon,
      this.prefixIconColor = Colors.black,
      this.suffixIcon = Icons.arrow_forward_ios_rounded,
      this.suffixIconColor = Colors.black,
      this.label = "Hellory Row Tile",
      required this.fontSize,
      this.fontColor = Colors.black,
      this.dividerRequired = false,
      this.onClick})
      : super(key: key);

  @override
  State<RowTileLight> createState() => _RowTileLightState();
}

class _RowTileLightState extends State<RowTileLight> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onClick ??
              () {
                if (kDebugMode) {
                  print("Hellory Row Tile Clicked");
                }
              },
          child: Container(
            padding: EdgeInsets.all(20.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  widget.prefixIcon,
                  color: widget.prefixIconColor,
                  size: 24.r,
                ),
                SizedBox(width: 10.w),
                Text(
                  widget.label,
                  style: CustomTextStyles.primaryTextStyle(
                      color: widget.fontColor, fontSize: widget.fontSize),
                ),
                const Spacer(),
                Icon(
                  widget.suffixIcon,
                  color: widget.suffixIconColor,
                  size: 24.r,
                ),
              ],
            ),
          ),
        ),
        (widget.dividerRequired)
            ? Divider(
                color: appBarBGColor,
                height: 1.h,
              )
            : const Divider(height: 0)
      ],
    );
  }
}
