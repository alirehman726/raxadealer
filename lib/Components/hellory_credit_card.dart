import 'package:raxaadmin/Controller/order_controller.dart';
import 'package:raxaadmin/Widgets/text_styles.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class HelloryCreditCard extends StatefulWidget {
  final int credit;
  const HelloryCreditCard({Key? key, this.credit = 0}) : super(key: key);

  @override
  State<HelloryCreditCard> createState() => _HelloryCreditCardState();
}

class _HelloryCreditCardState extends State<HelloryCreditCard> {
  final controller = Get.find<OrderController>();

  final LocalStorage storage = new LocalStorage('localstorage_app');
  @override
  void initState() {
    controller.getNewOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0.r),
          border: Border.all(color: primaryColor),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 4))
          ]),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Image.asset(
              Images.MASK_GROUP,
              fit: BoxFit.contain,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.h),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text("Today's Delivery",
                      style: CustomTextStyles.primaryTextStyle(
                          color: Colors.white, fontSize: 16.sp)),
                ),
              ),
              Obx(
                () => controller.loading.value
                    ? Padding(
                        padding: EdgeInsets.only(left: 20.w, top: 10.h),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          // color: Colors.yellow,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(left: 20.w, top: 10.h),
                        child: Text(
                          '${controller.pendingOrder_Data[0].pendingOrderCount} / ${controller.total_length.value}',
                          style: CustomTextStyles.primaryTextStyle(
                              color: Colors.white,
                              fontSize: 60.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
              )
            ],
          ),
          storage.getItem('EMPLOYEETYPE') == "contract"
              ? Padding(
                  padding: EdgeInsets.only(right: 10.w, bottom: 10.h),
                  child: Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    // child: Image.asset(
                    //   Images.LOGO,
                    //   fit: BoxFit.contain,
                    // ),
                    child: IconButton(
                        onPressed: () {
                          print("wallet");
                        },
                        icon: Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Colors.white,
                          size: 40,
                        )),
                  ),
                )
              : Text('')
        ],
      ),
    );
  }
}
