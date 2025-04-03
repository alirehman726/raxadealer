import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';

class NoData extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  const NoData(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  State<NoData> createState() => _NoDataState();
}

class _NoDataState extends State<NoData> {
  @override
  Widget build(BuildContext context) {
    // Initialize Screen Size Check
    ScreenUtil.init(context, designSize: const Size(360, 800));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 40.h),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            widget.image,
            height: 70,
            width: 70,
            color: Colors.grey[600],
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 10.h),
        Align(
          alignment: Alignment.center,
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: CustomTextStyles.primaryTextStyle(
                fontSize: 20.sp,
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w700),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            widget.description,
            textAlign: TextAlign.center,
            style: CustomTextStyles.primaryTextStyle(
                fontSize: 16.sp, color: Colors.black.withOpacity(0.6)),
          ),
        )
      ],
    );
  }
}
