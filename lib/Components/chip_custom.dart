import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Widgets/text_styles.dart';
import '../utils/color.dart';

class ChipCustom extends StatefulWidget {
  final String label;
  final int index;
  final void Function(int index) onDeleteClick;
  const ChipCustom({
    Key? key,
    required this.index,
    required this.label,
    required this.onDeleteClick
  }) : super(key: key);

  @override
  State<ChipCustom> createState() => _ChipCustomState();
}

class _ChipCustomState extends State<ChipCustom> {
  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(
        widget.label,
        style: CustomTextStyles.primaryTextStyle(
            color: Colors.white,
            fontSize: 9.sp
        ),
      ),
      padding: EdgeInsets.all(4.r),
      backgroundColor: Colors.black,
      deleteIcon: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.close_rounded,
          size: 12.r,
        ),
      ),
      deleteIconColor: primaryColor,
      onDeleted: () {
        widget.onDeleteClick(widget.index);
      }
    );
  }
}
