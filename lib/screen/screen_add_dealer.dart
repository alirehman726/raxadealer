import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/Controller/controller_AllDealer.dart';
import 'package:raxaadmin/Widgets/myToasts.dart';
import 'package:raxaadmin/screen/screen_dealer.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenAddDealer extends StatefulWidget {
  const ScreenAddDealer({super.key});

  @override
  State<ScreenAddDealer> createState() => _ScreenAddDealerState();
}

class _ScreenAddDealerState extends State<ScreenAddDealer> {
  String selectedValue = "Yes";
  List<String> options = ["Yes", "No"];

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<dynamic> cities = [];
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    fetchCities();
    loadUserData();
  }

  String? username;
  String? email;
  String? user_type;
  String? user_id;

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'ADMIN';
      email = prefs.getString('email') ?? 'example@gmail.com';
      user_type = prefs.getString('user_type') ?? 'dealer';
      user_id = prefs.getString('user_id') ?? '0';
    });
  }

  Future<void> fetchCities() async {
    final response =
        await http.get(Uri.parse('https://raxaspread.com/API/api/get-city'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> cityList = jsonResponse['data'];

      setState(() {
        cities = cityList;
      });
    } else {
      print("Failed to load cities");
    }
  }

  Future<void> doCallAPILogin() async {
    if (_image == null) {
      Fluttertoast.showToast(msg: "Please select in image");
      return;
    }
    doStartLoader(true);

    if (_formKey.currentState!.validate()) {
      dio.MultipartFile imageFile = await dio.MultipartFile.fromFile(
        _image!.path,
        filename: _image!.path.split('/').last,
      );
      dio.FormData body = dio.FormData.fromMap({
        "name": nameController.text,
        "email": emailController.text,
        "phone": mobileController.text,
        "address": addressController.text,
        // "username": usernameController.text,
        "password": passwordController.text,
        "city": selectedCity,
        "user_id": user_id,
        "type": user_type == "dealer" ? "retailer" : "user",
        "profile_image": imageFile,
      });
      var res = await AuthApis.addDealerAPI(body);

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _image;
  // Future<void> _pickImage() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
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
            backgroundColor: Colors.transparent, // Make AppBar transparent
            elevation: 0, // Remove shadow
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
            // title: Text(
            //   "Add new Retailer",
            //   style: TextStyle(color: Colors.white),
            // ),
            title: user_type == "dealer"
                ? Text(
                    "Add new Retailer",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  )
                : Text(
                    "Add new User",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
                margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xffe6f8ff),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 100,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: (() {
                              Color randomColor = getRandomColor();
                              return randomColor.withOpacity(0.5);
                            })(),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: ClipOval(
                                child: _image != null
                                    ? Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        backgroundColor: (() {
                                          Color randomColor = getRandomColor();
                                          return randomColor;
                                        })(),
                                        child: Text(
                                          'AD',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Center(
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     height: 80,
                    //     width: 80,
                    //     child: CircleAvatar(
                    //       radius: 60,
                    //       backgroundColor: (() {
                    //         Color randomColor = getRandomColor();
                    //         return randomColor.withOpacity(0.5);
                    //       })(),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8),
                    //         child: ClipOval(
                    //           child: CircleAvatar(
                    //             radius: 50,
                    //             backgroundColor: (() {
                    //               Color randomColor = getRandomColor();
                    //               return randomColor;
                    //             })(),
                    //             child: Text(
                    //               'AD',
                    //               style: TextStyle(
                    //                 fontSize: 20,
                    //                 color: Colors.white,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff737c80),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please insert valid name";
                        }
                        if (value.length < 3) {
                          return "Name should be min 3 characters long";
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe6f8ff),
                        labelText: "Enter your Name",
                        // labelStyle: TextStyle(
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.black87,
                        // ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Phone no.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff737c80),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: mobileController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      ],
                      validator: (value) {
                        if (value!.length != 10) {
                          return 'Mobile Number must be of 10 digit';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe6f8ff),
                        labelText: "Enter your Mobile Number",
                        // hintStyle: TextStyle(
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.black87,
                        // ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),
                    Text(
                      "City",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff737c80),
                      ),
                    ),
                    const SizedBox(height: 5),

                    DropdownButtonFormField<String>(
                      value: selectedCity,
                      items: cities.map<DropdownMenuItem<String>>((city) {
                        return DropdownMenuItem<String>(
                          value: city['id'].toString(),
                          child: Text(city['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe6f8ff),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select a city";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff737c80),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: addressController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please insert valid address";
                        }
                        if (value.length < 3) {
                          return "Address should be min 3 characters long";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe6f8ff),
                        labelText: "Enter your Address",
                        // hintStyle: TextStyle(
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.black87,
                        // ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "Email ID",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff737c80),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "Please_insert_email_address".tr;
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(email)) {
                          return "Please_insert_a_valid_email_address".tr;
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe6f8ff),
                        labelText: "Enter your Email Address",
                        // hintStyle: TextStyle(
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.black87,
                        // ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff737c80),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please insert valid Password";
                        }
                        if (value.length < 3) {
                          return "Username should be min 3 characters long";
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe6f8ff),
                        labelText: "Enter your Password",
                        // hintStyle: TextStyle(
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.black87,
                        // ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),

                    //
                    //

                    const SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 80,
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 15),
                            decoration: BoxDecoration(
                              color: Color(0xffFF8800),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Get.back();
                            doCallAPILogin();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 80,
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 15),
                            decoration: BoxDecoration(
                              color: Color(0xff0158FA),
                              borderRadius: BorderRadius.circular(10),
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
      ),
    );
  }
}
