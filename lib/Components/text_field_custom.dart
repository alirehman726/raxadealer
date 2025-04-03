import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raxaadmin/utils/color.dart';

class TextFieldHellory extends StatefulWidget {
  final bool enabled;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final String? hintText;
  final TextStyle? labelTextStyle;
  final Icon? prefixIcon;
  final Color? fillColor;
  final OutlineInputBorder? disabledBorder;
  final OutlineInputBorder? border;
  final bool isPassword;
  final bool? passwordVisibility;
  final List<TextInputFormatter>? inputFormat;
  final int? maxLength;
  final int? maxLines;
  final void Function(String?)? onSubmitted;
  final void Function()? suffixClicked;
  final void Function()? onClick;
  final void Function(String?)? onChanged;

  const TextFieldHellory(
      {Key? key,
      this.enabled = true,
      this.inputType,
      this.inputAction = TextInputAction.next,
      this.controller,
      this.validator,
      this.labelText,
      this.labelTextStyle,
      this.hintText,
      this.prefixIcon,
      this.fillColor,
      this.disabledBorder,
      this.border,
      this.isPassword = false,
      this.passwordVisibility,
      this.inputFormat,
      this.maxLength,
      this.maxLines,
      this.suffixClicked,
      this.onClick,
      this.onSubmitted,
      this.onChanged})
      : super(key: key);

  @override
  State<TextFieldHellory> createState() => _TextFieldHelloryState();
}

class _TextFieldHelloryState extends State<TextFieldHellory> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      keyboardType: widget.inputType ?? TextInputType.text,
      textInputAction: widget.inputAction,
      controller: widget.controller ?? TextEditingController(),
      autofocus: true,
      onChanged: widget.onChanged ??
          (value) {
            print("Hellory TextField Changed | value: $value");
          },
      onFieldSubmitted: widget.onSubmitted ??
          (value) {
            print("Hellory TextField Submitted | value: $value");
          },
      validator: widget.validator ??
          (value) {
            return null;
          },
      decoration: InputDecoration(
        labelText: widget.labelText ?? 'Hellory',
        hintStyle: widget.labelTextStyle ?? TextStyle(),
        hintText: widget.hintText ?? "",
        contentPadding: EdgeInsets.fromLTRB(18.r, 18.r, 18.r, 18.r),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: widget.prefixIcon ?? const Icon(Icons.abc),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: whiteBgColor)),
        fillColor: widget.fillColor ?? primaryColor,
        filled:
            (widget.fillColor == null || widget.fillColor.toString().isEmpty)
                ? false
                : true,
        disabledBorder: widget.disabledBorder ??
            widget.border ??
            OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
                borderSide: BorderSide(color: whiteBgColor, width: 0)),
        border: widget.border ??
            OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0.r))),
        suffixIcon: (widget.isPassword == true)
            ? InkWell(
                canRequestFocus: false,
                onTap: widget.suffixClicked ??
                    () {
                      setState(() {});
                    },
                child: Icon(
                    widget.passwordVisibility == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 24.r),
              )
            : null,
      ),
      obscureText: (widget.isPassword == true)
          ? ((widget.passwordVisibility == true) ? false : true)
          : false,
      inputFormatters: widget.inputFormat ?? [],
      maxLength: widget.maxLength,
      maxLines: widget.maxLines ?? 1,
      onTap: widget.onClick ??
          () {
            if (kDebugMode) {
              print("Hellory Text Field Clicked");
            }
          },
      style: TextStyle(fontSize: 14.sp),
    );
  }
}
