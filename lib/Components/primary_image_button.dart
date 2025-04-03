import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:raxaadmin/utils/images.dart';

class PrimaryImageButton extends StatefulWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final String label;
  final String icon;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final void Function()? onClick;

  const PrimaryImageButton(
      {Key? key,
      this.height = 60.0,
      this.width = double.infinity,
      this.backgroundColor = Colors.white,
      this.borderColor = Colors.white,
      this.borderRadius = 10.0,
      this.label = "Hellory Icon",
      required this.icon,
      this.fontColor = Colors.black,
      this.fontSize = 16.0,
      this.fontWeight = FontWeight.bold,
      this.onClick})
      : super(key: key);

  @override
  State<PrimaryImageButton> createState() => _PrimaryImageButtonState();
}

class _PrimaryImageButtonState extends State<PrimaryImageButton> {
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
            Image.asset(widget.icon, fit: BoxFit.contain),
            const SizedBox(width: 10),
            Text(
              widget.label,
              style: CustomTextStyles.primaryTextStyle(
                  color: widget.fontColor,
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight),
            ),
          ],
        ),
      ),
    );
  }
}
