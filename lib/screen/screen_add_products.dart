import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/Controller/controller_allProducts.dart';
import 'package:raxaadmin/utils/images.dart';

import 'screen_product.dart';

class ScreenAddProducts extends StatefulWidget {
  const ScreenAddProducts({super.key});

  @override
  State<ScreenAddProducts> createState() => _ScreenAddProductsState();
}

class _ScreenAddProductsState extends State<ScreenAddProducts> {
  String selectedValue = "Yes";
  List<String> options = ["Yes", "No"];
  File? _image;
  final _formKey = GlobalKey<FormState>();
  String productName = '';
  String description = '';
  String netQuantity = '';
  String weight = '';
  String packingType = '';
  String flavour = '';
  String price = '';
  // String addedDate = 'Select Date';

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
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // void _showDatePicker() async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (pickedDate != null && pickedDate != DateTime.now()) {
  //     setState(() {
  //       addedDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
  //     });
  //   }
  // }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Perform submission logic here
      doCallAPILogin();
      // Get.snackbar("Success", "Product added successfully!");
    }
  }

  Future<void> doCallAPILogin() async {
    print(productName);
    print(description);
    print(price);
    print(netQuantity);
    print(selectedValue);
    print(weight);
    print(packingType);
    print(flavour);
    print("flavour______");
    if (_image == null) {
      Fluttertoast.showToast(msg: "Please select in image");
      return;
    }

    doStartLoader(true);

    try {
      dio.MultipartFile imageFile = await dio.MultipartFile.fromFile(
        _image!.path,
        filename: _image!.path.split('/').last,
      );
      dio.FormData body = dio.FormData.fromMap({
        "product_name": productName,
        "discription": description,
        "price": price,
        "quantity": netQuantity,
        "stock": selectedValue,
        "weight": "${weight}/kg",
        "packing_type": packingType,
        "flavour": flavour,
        // "added_date": addedDate,
        "image": imageFile,
      });

      var res = await AuthApis.addProductAPI(body);

      if (res != null) {
        Map<String, dynamic> response = json.decode(res.toString());
        if (response['status'] == true) {
          Fluttertoast.showToast(msg: response['message'].toString());
          Get.offAll(() => ScreenProduct());

          final controllerAllProducts = Get.find<ControllerAllproducts>();
          await controllerAllProducts.controllerAllProducts();
          controllerAllProducts.update();
        } else {
          Fluttertoast.showToast(msg: response['message'].toString());
        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong. Try again.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    } finally {
      doStartLoader(false);
    }
  }

  // Future<void> doCallAPILogin() async {
  //   doStartLoader(true);

  //   print(productName);
  //   print(description);
  //   print(price);
  //   print(netQuantity);
  //   print(selectedValue);
  //   print(weight);
  //   print(packingType);
  //   print(flavour);
  //   print(addedDate);
  //   print(_image);

  //   dio.FormData body = dio.FormData.fromMap({
  //     // "ads_id": "",
  //     // 'status': status.toString(),
  //     //
  //     "product_name": productName,
  //     "discription": description,
  //     "price": price,
  //     "quantity": netQuantity,
  //     "stock": selectedValue,
  //     "weight": "${weight}/kg",
  //     "packing_type": packingType,
  //     "flavour": flavour,
  //     "added_date": addedDate,
  //     // "image":_image,
  //     "image": await dio.MultipartFile.fromFile(
  //       _image!.path, // File ka path
  //       filename: _image!.path.split('/').last, // File ka naam
  //       contentType: MediaType('image', 'jpeg'), // Correct MIME type
  //     ),
  //   });

  //   var res = await AuthApis.addProductAPI(body);

  //   if (res != null) {
  //     Map<String, dynamic> response = json.decode(res.toString());
  //     print(response);
  //     print(response['status']);
  //     print('Hello TVS');
  //     if (response['status'] == true) {
  //       print('Rehmanali');
  //       print(response['message']);
  //       doStartLoader(false);
  //       Fluttertoast.showToast(
  //         msg: response['message'].toString(),
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //       );
  //       // SnackbarCustom.success("Success", response['message'].toString());

  //       Get.offAll(() => ScreenProduct());

  //       final controllerAllProducts = Get.find<ControllerAllproducts>();

  //       await controllerAllProducts.controllerAllProducts();
  //       controllerAllProducts.update();
  //     } else {
  //       doStartLoader(false);
  //       Fluttertoast.showToast(
  //         msg: response['message'].toString(),
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //       );
  //       // SnackbarCustom.error("Error", response['message']);
  //     }
  //   } else {
  //     doStartLoader(false);
  //     Fluttertoast.showToast(
  //       msg: "Something Error",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //     // SnackbarCustom.error("Error",
  //     //     "Unable to login at the moment. Please try again after sometime.");
  //   }
  // }

  doStartLoader(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  bool isLoading = false;
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
            title: Text(
              "Add PRODUCT",
              style: TextStyle(color: Colors.white),
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
                padding: EdgeInsets.all(5),
                color: Color(0xff01B8FA),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Product',
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff3C3E89),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Divider(
                        color: Color(0xff01B8FA),
                        height: 2,
                        thickness: 3,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Text(
                          'Add New Product',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3C3E89),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Color(0xffcccccc),
                              thickness: 2, // Use thickness to make it visible
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Container(
                            //   height: 150,
                            //   width: 150,
                            //   color: Colors.red,
                            // ),
                            // Image Picker
                            GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: _image != null
                                      ? DecorationImage(
                                          image: FileImage(_image!),
                                          fit: BoxFit.cover,
                                        )
                                      : DecorationImage(
                                          image: NetworkImage(
                                              "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            // Container(
                            //   height: 100,
                            //   width: 100,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(8.0),
                            //     image: DecorationImage(
                            //       image: NetworkImage(
                            //           "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"),
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mandatory',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff3C3E89),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Hight : 500px',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w200,
                                      color: Color(0xff3C3E89),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Weight : 500px',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w200,
                                      color: Color(0xff3C3E89),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Text(
                            //     "Product Name",
                            //     style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.blue[900],
                            //     ),
                            //   ),
                            // ),
                            // TextField(
                            //   decoration: InputDecoration(
                            //     hintText: "",
                            //     hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            //     enabledBorder: UnderlineInputBorder(
                            //       borderSide:
                            //           BorderSide(color: Colors.blueAccent),
                            //     ),
                            //   ),
                            // ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Product Name",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter product name';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                productName = value;
                              },
                            ),
                            SizedBox(height: 20),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Text(
                            //     "Discrption",
                            //     style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.blue[900],
                            //     ),
                            //   ),
                            // ),
                            // TextField(
                            //   obscureText: true,
                            //   decoration: InputDecoration(
                            //     hintText: "",
                            //     enabledBorder: UnderlineInputBorder(
                            //       borderSide:
                            //           BorderSide(color: Colors.blueAccent),
                            //     ),
                            //   ),
                            // ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Description",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter description';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                description = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'In Stock : ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff3C3E89),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 60,
                                      height: 25,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blue,
                                            width: 2), // Blue border
                                        borderRadius: BorderRadius.circular(
                                            5), // Rounded corners
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: selectedValue,
                                          items: options.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedValue = newValue!;
                                            });
                                          },
                                          icon: Icon(Icons.arrow_drop_down,
                                              color: Colors
                                                  .black), // Dropdown arrow
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Net Quantity : ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff3C3E89),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 60,
                                      height: 25,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: "",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'net quantity';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          netQuantity = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 17),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Weight : ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff3C3E89),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 60,
                                      height: 25,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: "0g/ Kg",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'weight';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          weight = value;
                                        },
                                      ),
                                      // child: TextField(
                                      //   decoration: InputDecoration(
                                      //     hintText: "0g/ Kg",
                                      //     hintStyle: TextStyle(
                                      //         fontWeight: FontWeight.bold),
                                      //     enabledBorder: UnderlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //           color: Colors.blueAccent),
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Packing Type : ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff3C3E89),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 60,
                                      height: 25,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: "",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'packing type';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          packingType = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 17),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Flavour : ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff3C3E89),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 60,
                                      height: 25,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: "",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter flavour';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          flavour = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Price : ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff3C3E89),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 60,
                                      height: 25,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: "",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter Price';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          price = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 17),
                            // Row(
                            //   children: [
                            //     Text(
                            //       'Added Date :',
                            //       style: TextStyle(
                            //         fontSize: 12,
                            //         fontWeight: FontWeight.bold,
                            //         color: Color(0xff3C3E89),
                            //       ),
                            //     ),
                            //     const SizedBox(width: 10),
                            //     Text(
                            //       ' 31/02/2025 ',
                            //       style: TextStyle(
                            //         fontSize: 12,
                            //         fontWeight: FontWeight.bold,
                            //         color: Color(0xff3C3E89),
                            //       ),
                            //     ),
                            //     const SizedBox(width: 10),
                            //     Icon(
                            //       Icons.calendar_month_outlined,
                            //       color: Color(0xff3C3E89),
                            //     )
                            //   ],
                            // ),
                            // Added Date
                            // GestureDetector(
                            //   onTap: _showDatePicker,
                            //   child: Row(
                            //     children: [
                            //       Text(
                            //         'Added Date:     $addedDate',
                            //         style: TextStyle(
                            //           fontSize: 12,
                            //           fontWeight: FontWeight.bold,
                            //           color: Color(0xff3C3E89),
                            //         ),
                            //       ),
                            //       const SizedBox(width: 10),
                            //       Icon(
                            //         Icons.calendar_month_outlined,
                            //         color: Color(0xff3C3E89),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            const SizedBox(height: 17),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffff8800),
                                      borderRadius: BorderRadius.circular(5),
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
                                // InkWell(
                                //   onTap: () {
                                //     _submit;
                                //     // Get.back();
                                //   },
                                //   child: Container(
                                //     padding: EdgeInsets.only(
                                //         left: 10,
                                //         right: 10,
                                //         top: 10,
                                //         bottom: 10),
                                //     decoration: BoxDecoration(
                                //       color: Color(0xff01b8fa),
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
                                  onTap: _submit,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(0xff01b8fa),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
