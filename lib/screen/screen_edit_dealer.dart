import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/Controller/controller_AllDealer.dart';
import 'package:raxaadmin/Controller/controller_EditDealer.dart';
import 'package:raxaadmin/Widgets/myToasts.dart';
import 'package:raxaadmin/screen/screen_dealer.dart';
import 'package:raxaadmin/utils/images.dart';

class ScreenEditDealer extends StatefulWidget {
  final int id;
  final String colorCode;
  const ScreenEditDealer(
      {super.key, required this.id, required this.colorCode});

  @override
  State<ScreenEditDealer> createState() => _ScreenEditDealerState();
}

class _ScreenEditDealerState extends State<ScreenEditDealer> {
  String selectedValue = "Yes";
  List<String> options = ["Yes", "No"];
  bool isEditButton = false;

  final controllerEditDealer = Get.find<ControllerEditDealer>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controllerEditDealer.controllerEditDealer(widget.id);
  }

  void toggleEdit() {
    setState(() {
      isEditButton = !isEditButton;
      if (isEditButton) {
        nameController.text = controllerEditDealer.editDealer[0].name;
        phoneController.text = controllerEditDealer.editDealer[0].phnNumber;
        addressController.text = controllerEditDealer.editDealer[0].address;
        emailController.text = controllerEditDealer.editDealer[0].email;
        usernameController.text = controllerEditDealer.editDealer[0].username;
      }
    });
  }

  void submitData(int id) async {
    if (_formKey.currentState!.validate()) {
      dio.FormData body = dio.FormData.fromMap({
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "address": addressController.text,
        "username": usernameController.text,
      });
      var res = await AuthApis.editDealerAPI(body, id);

      if (res != null) {
        Map<String, dynamic> response = json.decode(res.toString());
        print(response);
        print(response['status']);
        if (response['status'] == true) {
          Fluttertoast.showToast(
            msg: response['message'].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Get.offAll(() => ScreenDealer());

          final controllerAllDealer = Get.find<ControllerAllDealer>();

          await controllerAllDealer.controllerAllDealer();
          controllerAllDealer.update();
        } else {
          doStartLoader(false);
          // SnackbarCustom.error("Error", response['message']);
          Fluttertoast.showToast(
            msg: response['message'].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        doStartLoader(false);
        Fluttertoast.showToast(
          msg: "Something Error ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // SnackbarCustom.error("Error",
        //     "Unable_to_login_at_the_moment_Please_try_again_after_sometime");
      }
    } else {
      longToastMessage("Please Enter Valid Mobile Number!");
    }
  }

  bool isLoading = false;

  doStartLoader(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  String getInitials(String name) {
    List<String> words = name.trim().split(" ");
    if (words.length == 1) {
      return words[0][0]
          .toUpperCase(); // Sirf ek word hai to uska pehla letter return karega
    } else {
      return (words[0][0] + words[1][0])
          .toUpperCase(); // Pehle aur doosre word ka first letter return karega
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xffccf1fe),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff01B8FA),
                Color(0xff2596be),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  Images.PROFILE_ICON,
                  height: 35,
                  width: 35,
                ),
              ),
            ],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            centerTitle: true,
            title: Text(
              "Edit Retailer",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Obx(
        () {
          if (controllerEditDealer.loading.value) {
            return Center(child: CircularProgressIndicator(color: Colors.red));
          }
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffe6f8ff),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: getColorFromHex(widget.colorCode)
                                .withOpacity(0.5),
                            child: Text(
                              getInitials(
                                  controllerEditDealer.editDealer[0].name),
                              // 'AD',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment:
                              Alignment.center, // Poore row ko center karega
                          child: IntrinsicWidth(
                            // Row ka width sirf jitna zaroori hai utna hi hoga
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                isEditButton
                                    ? Expanded(
                                        child: TextFormField(
                                          controller: nameController,
                                          decoration: InputDecoration(
                                              labelText: 'Name'),
                                        ),
                                      )
                                    : Expanded(
                                        child: Text(
                                          controllerEditDealer
                                              .editDealer[0].name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff3C3E89),
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                SizedBox(
                                    width: 10), // Thoda spacing rakhne ke liye
                                InkWell(
                                  onTap: toggleEdit,
                                  child: Icon(
                                    Icons.edit,
                                    color: Color(0xff0158FA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     isEditButton
                        //         ? Expanded(
                        //             child: TextFormField(
                        //               controller: nameController,
                        //               decoration:
                        //                   InputDecoration(labelText: 'Name'),
                        //             ),
                        //           )
                        //         : Expanded(
                        //             child: Text(
                        //               controllerEditDealer.editDealer[0].name,
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(

                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Color(0xff3C3E89),
                        //               ),
                        //               softWrap:
                        //                   true, // Text ko automatic next line me shift karne dega
                        //             ),
                        //           ),
                        //     SizedBox(width: 15),
                        //     InkWell(
                        //       onTap: toggleEdit,
                        //       child: Icon(
                        //         Icons.edit,
                        //         color: Color(0xff0158FA),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        SizedBox(height: 30),
                        buildEditableField("Phone no.", phoneController,
                            controllerEditDealer.editDealer[0].phnNumber),
                        buildEditableField("Address", addressController,
                            controllerEditDealer.editDealer[0].address),
                        buildEditableField("Email ID", emailController,
                            controllerEditDealer.editDealer[0].email),
                        buildEditableField("Username", usernameController,
                            controllerEditDealer.editDealer[0].username),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: toggleEdit,
                              child: Container(
                                alignment: Alignment.center,
                                width: 70,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(0xff3C3D86),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  isEditButton ? 'Save' : 'Edit',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {},
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     width: 70,
                            //     padding: EdgeInsets.all(10),
                            //     decoration: BoxDecoration(
                            //       color: Color(0xff01B8FA),
                            //       borderRadius: BorderRadius.circular(5),
                            //     ),
                            //     child: Text(
                            //       'Submit',
                            //       style: TextStyle(
                            //         fontSize: 10,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            InkWell(
                              onTap: () {
                                submitData(
                                    controllerEditDealer.editDealer[0].id);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 70,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(0xff01B8FA),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildEditableField(
      String label, TextEditingController controller, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xff737c80),
          ),
        ),
        SizedBox(height: 5),
        isEditButton
            ? TextFormField(
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(border: OutlineInputBorder()),
              )
            : Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff404042),
                ),
              ),
        SizedBox(height: 30),
      ],
    );
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor
        .replaceAll("#", "")
        .toUpperCase(); // "#" ko remove kare aur uppercase kare

    final validHex =
        RegExp(r'^[0-9A-Fa-f]{6}$'); // Sirf valid hex colors allow kare
    if (!validHex.hasMatch(hexColor)) {
      print("Invalid color code: $hexColor");
      return Colors.primaries[
          hexColor.hashCode % Colors.primaries.length]; // Random unique color
    }

    return Color(int.parse("0xff$hexColor"));
  }
}
