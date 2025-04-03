import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raxaadmin/utils/color.dart';

class DropdownTextFieldHellory extends StatefulWidget {
  final Icon? prefixIcon;
  final Color? fillColor;
  final OutlineInputBorder? disabledBorder;
  final OutlineInputBorder? border;
  final String? selectedValue;
  final String? label;
  final List<String> items;
  final void Function(String?)? onChanged;
  final bool? enabled;

  const DropdownTextFieldHellory(
      {Key? key,
      this.prefixIcon,
      this.fillColor,
      this.disabledBorder,
      this.border,
      this.selectedValue,
      this.label,
      required this.items,
      this.onChanged,
      this.enabled})
      : super(key: key);

  @override
  State<DropdownTextFieldHellory> createState() =>
      _DropdownTextFieldHelloryState();
}

class _DropdownTextFieldHelloryState extends State<DropdownTextFieldHellory> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: widget.fillColor ?? Colors.white,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: widget.prefixIcon ?? const Icon(Icons.male),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: whiteBgColor)),
        fillColor: widget.fillColor ?? primaryColor,
        filled:
            (widget.fillColor == null || widget.fillColor.toString().isEmpty)
                ? false
                : true,
        contentPadding: EdgeInsets.fromLTRB(18.r, 18.r, 18.r, 18.r),
        disabledBorder: widget.disabledBorder ??
            widget.border ??
            OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0.r))),
        border: widget.border ??
            OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0.r))),
        labelText: widget.label ?? "Hellory Dropdown",
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
      items: widget.items.map((item) {
        return DropdownMenuItem(value: item.toLowerCase(), child: Text(item));
      }).toList(),
      value: widget.selectedValue ?? "",
      onChanged: (widget.enabled ?? false) ? widget.onChanged : null,
    );
  }
}
