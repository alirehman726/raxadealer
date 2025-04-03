import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';

class CheckboxHellory extends StatefulWidget {
  final double size;
  final double shapeRadius;
  final bool value;
  final Color checkColor;
  final Color activeColor;
  final String label;
  final double fontSize;
  final Color fontColor;
  final double space;
  final void Function(bool?)? onChange;
  final void Function()? onClick;

  const CheckboxHellory(
      {Key? key,
      this.size = 20.0,
      this.shapeRadius = 4.0,
      this.value = false,
      this.checkColor = Colors.white,
      this.activeColor = Colors.black,
      this.label = "Hellory Checkbox",
      this.fontSize = 14.0,
      this.fontColor = Colors.black,
      this.space = 5.0,
      this.onChange,
      this.onClick})
      : super(key: key);

  @override
  State<CheckboxHellory> createState() => _CheckboxHelloryState();
}

class _CheckboxHelloryState extends State<CheckboxHellory> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: widget.size,
          width: widget.size,
          child: Checkbox(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.shapeRadius)),
            value: widget.value,
            onChanged: widget.onChange ??
                (value) {
                  if (kDebugMode) {
                    print("Checkbox clicked $value");
                  }
                },
            checkColor: widget.checkColor,
            activeColor: widget.activeColor,
          ),
        ),
        SizedBox(width: widget.space),
        InkWell(
          onTap: widget.onClick ??
              () {
                if (kDebugMode) {
                  print("Checkbox label clicked");
                }
              },
          child: Text(
            widget.label,
            style: CustomTextStyles.primaryTextStyle(
                color: widget.fontColor, fontSize: widget.fontSize),
          ),
        )
      ],
    );
  }
}
