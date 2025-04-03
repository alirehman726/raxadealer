import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';

class PrimaryButton extends StatefulWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final String label;
  final Color fontColor;
  final double fontSize;
  final void Function()? onClick;

  const PrimaryButton(
      {Key? key,
      this.height = 60.0,
      this.width = double.infinity,
      this.backgroundColor = Colors.black,
      this.borderColor = Colors.black,
      this.borderRadius = 10.0,
      this.label = "Hellory Button",
      this.fontColor = Colors.white,
      this.fontSize = 16.0,
      this.onClick})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick ??
          () {
            if (kDebugMode) {
              print("Primary button clicked!");
            }
          },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            border: Border.all(color: widget.borderColor),
            borderRadius: BorderRadius.circular(widget.borderRadius)),
        child: Center(
          child: Text(
            widget.label,
            style: CustomTextStyles.primaryTextStyle(
                color: widget.fontColor, fontSize: widget.fontSize),
          ),
        ),
      ),
    );
  }
}
