import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';

class LoadingButton extends StatefulWidget {
  final bool isLoading;
  final double outerLeft;
  final double outerRight;
  final double width;
  final double height;
  final String label;
  final Color fontColor;
  final double fontSize;
  final Color backgroundColor;
  final double borderRadius;
  final Color borderColor;
  final Color progressColor;
  final void Function()? onClick;
  final void Function()? onProgressClick;

  const LoadingButton(
      {Key? key,
      this.isLoading = false,
      this.outerLeft = 0,
      this.outerRight = 0,
      this.width = double.infinity,
      this.height = 60,
      this.label = 'Loading Button Hellory',
      this.fontColor = Colors.white,
      this.fontSize = 16.0,
      this.backgroundColor = Colors.black,
      this.borderRadius = 10.0,
      this.borderColor = Colors.black,
      this.progressColor = Colors.white,
      this.onClick,
      this.onProgressClick})
      : super(key: key);

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Padding(
            padding: EdgeInsets.only(
                left: widget.outerLeft, right: widget.outerRight),
            child: InkWell(
              onTap: widget.onProgressClick ??
                  () {
                    if (kDebugMode) {
                      print("Progress clicked");
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
                  child: CircularProgressIndicator(
                    color: widget.progressColor,
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
                left: widget.outerLeft, right: widget.outerRight),
            child: InkWell(
              onTap: widget.onClick ??
                  () {
                    if (kDebugMode) {
                      print("Button clicked");
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
            ),
          );
  }
}
