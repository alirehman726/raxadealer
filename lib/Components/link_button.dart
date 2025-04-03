import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';

class LinkButton extends StatefulWidget {
  final String label;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final void Function()? onClick;

  const LinkButton(
      {Key? key,
      this.label = "Hellory Link",
      this.fontColor = Colors.black,
      this.fontSize = 14.0,
      this.fontWeight = FontWeight.w500,
      this.onClick})
      : super(key: key);

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick ??
          () {
            if (kDebugMode) {
              print("Link clicked");
            }
          },
      child: Text(
        widget.label,
        style: CustomTextStyles.primaryTextStyle(
            color: widget.fontColor,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight),
      ),
    );
  }
}
