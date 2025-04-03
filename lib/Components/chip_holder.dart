import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raxaadmin/Components/chip_custom.dart';
import 'package:raxaadmin/Components/primary_icon_button.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';
import 'package:raxaadmin/utils/color.dart';

class ChipHolder extends StatefulWidget {
  final bool isContact;
  final IconData prefixIcon;
  final Color prefixIconColor;
  double prefixIconSize;
  final IconData suffixIcon;
  final Color suffixIconColor;
  double sufffixIconSize;
  final List<Widget> items;
  final void Function()? onSuffixClick;

  ChipHolder(
      {Key? key,
      required this.isContact,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.prefixIconColor,
      required this.suffixIconColor,
      this.prefixIconSize = 24.0,
      this.sufffixIconSize = 24.0,
      required this.items,
      this.onSuffixClick})
      : super(key: key);

  @override
  State<ChipHolder> createState() => _ChipHolderState();
}

class _ChipHolderState extends State<ChipHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: whiteBgColor, borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(18.0.r),
            child: Icon(
              widget.prefixIcon,
              size: widget.prefixIconSize,
              color: widget.prefixIconColor,
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(top: 6.r, bottom: 6.r),
            child: Wrap(
                spacing: 4.r,
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 0,
                children: widget.items),
          )),
          PrimaryIconButton(
            width: 50.r,
            height: 50.r,
            backgroundColor: Colors.transparent,
            borderRadius: 25.r,
            icon: Icon(
              Icons.arrow_circle_right_outlined,
              size: 24.r,
            ),
            onClick: widget.onSuffixClick ??
                () {
                  print("Hellory Suffixed clicked");
                },
          )
        ],
      ),
    );
  }
}
