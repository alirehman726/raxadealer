import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:raxaadmin/utils/images.dart';

class PrimaryIconButton extends StatefulWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final String? label;
  final Icon? icon;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final void Function()? onClick;

  const PrimaryIconButton(
      {Key? key,
      this.height = 60.0,
      this.width = double.infinity,
      this.backgroundColor = Colors.white,
      this.borderColor = Colors.white,
      this.borderRadius = 10.0,
      this.label,
      this.icon,
      this.fontColor = Colors.black,
      this.fontSize = 16.0,
      this.fontWeight = FontWeight.bold,
      this.onClick})
      : super(key: key);

  @override
  State<PrimaryIconButton> createState() => _PrimaryIconButtonState();
}

class _PrimaryIconButtonState extends State<PrimaryIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick ??
          () {
            if (kDebugMode) {
              print("Hellory Icon Button Clicked");
            }
          },
      child: Container(
        alignment: Alignment.center,
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: widget.backgroundColor,
            border: Border.all(color: widget.borderColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (widget.label != null)
                ? Text(
                    widget.label ?? "",
                    style: CustomTextStyles.primaryTextStyle(
                        color: widget.fontColor,
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight),
                  )
                : const SizedBox(
                    width: 0,
                  ),
            (widget.label != null)
                ? const SizedBox(width: 10)
                : const SizedBox(width: 0),
            (widget.icon != null)
                ? (widget.icon ?? const SizedBox(width: 0))
                : const SizedBox(width: 0)
          ],
        ),
      ),
    );
  }
}
