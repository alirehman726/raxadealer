import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';
import 'package:raxaadmin/utils/color.dart';

class WelcomeBlock extends StatefulWidget {
  final String name;
  const WelcomeBlock({Key? key, required this.name}) : super(key: key);

  @override
  State<WelcomeBlock> createState() => _WelcomeBlockState();
}

class _WelcomeBlockState extends State<WelcomeBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome,",
          textAlign: TextAlign.start,
          style: CustomTextStyles.primaryTextStyle(
              color: Colors.black, fontSize: 18.sp),
        ),
        Text(
          widget.name,
          style: CustomTextStyles.primaryTextStyle(
              color: primaryColor,
              fontSize: 28.sp,
              fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
