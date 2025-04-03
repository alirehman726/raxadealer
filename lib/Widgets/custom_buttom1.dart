import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color.dart';

class Custom1Button extends StatelessWidget {
  final double left;
  final double right;
  final Function() onTap;
  final String title;

  Custom1Button(this.title, this.left, this.right, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 45.0,
          width: Get.width,
          decoration: new BoxDecoration(
            color: primaryColor,
            shape: BoxShape.rectangle,
            //  border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: white, fontSize: 16),
              // style: Theme.of(context)
              //     .textTheme
              //     .button!
              //     .copyWith(color: white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class Custom1ButtonDisabled extends StatelessWidget {
  final double left;
  final double right;
  final String title;

  Custom1ButtonDisabled(
    this.title,
    this.left,
    this.right,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: InkWell(
        child: Container(
          height: 45.0,
          width: Get.width,
          decoration: new BoxDecoration(
            color: grey,
            shape: BoxShape.rectangle,
            //  border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Center(
            child: Text(
              title,

              style: TextStyle(color: white, fontSize: 16),
              // style: Theme.of(context)
              //     .textTheme
              //     .button!
              //     .copyWith(color: white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class Custom1ButtonProgress extends StatelessWidget {
  final double left;
  final double right;

  Custom1ButtonProgress(
    this.left,
    this.right,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 45.0,
          width: Get.width,
          decoration: new BoxDecoration(
            // color: darkButtonColor,
            color: primaryColor,
            shape: BoxShape.rectangle,
            //  border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: white,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomFieldProgress extends StatelessWidget {
  final double left;
  final double right;

  CustomFieldProgress(
    this.left,
    this.right,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 50.0,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: grey),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
      ),
    );
  }
}

goBackButton() {
  return GestureDetector(
    onTap: () {
      Get.back();
    },
    child: Row(
      children: [
        Icon(
          Icons.arrow_back,
          color: primaryColor,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'go_back'.tr,
          style: TextStyle(color: primaryColor, fontSize: 19),
        ),
      ],
    ),
  );
}

class CustomTabWithIcon extends StatelessWidget {
  final icon;
  final title;
  final onTap;
  final color;

  CustomTabWithIcon(
      {Key? key, this.icon, this.title, this.onTap, this.color = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                title,

                style: TextStyle(color: Colors.black, fontSize: 16),
                // style: Theme.of(context)
                //     .textTheme
                //     .button!
                //     .copyWith(color: Colors.black, fontSize: 16),
              ),
            ),
            Icon(
              icon,
              color: primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
