// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class ScreenAddProducts extends StatefulWidget {
//   const ScreenAddProducts({super.key});

//   @override
//   State<ScreenAddProducts> createState() => _ScreenAddProductsState();
// }

// class _ScreenAddProductsState extends State<ScreenAddProducts> {
//   String selectedValue = "Yes";
//   List<String> options = ["Yes", "No"];
//   File? _image; // Variable to hold the selected image
//   final _formKey = GlobalKey<FormState>(); // Form key for validation
//   String productName = '';
//   String description = '';
//   String netQuantity = '';
//   String weight = '';
//   String packingType = '';
//   String addedDate = 'Select Date';

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   void _showDatePicker() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null && pickedDate != DateTime.now()) {
//       setState(() {
//         addedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
//       });
//     }
//   }

//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       // Perform submission logic here
//       Get.snackbar("Success", "Product added successfully!");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Color(0xffccf1fe),
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xff01B8FA),
//                 Color(0xff2596be),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 10),
//                 child: Image.asset(
//                   'assets/profile_icon.png', // Update with your asset path
//                   height: 35,
//                   width: 35,
//                 ),
//               ),
//             ],
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios_new_rounded,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 Get.back();
//               },
//             ),
//             centerTitle: true,
//             title: Text(
//               "Add PRODUCT",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(5),
//                 color: Color(0xff01B8FA),
//               ),
//               const SizedBox(height: 5),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Add Product',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff3C3E89),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 100,
//                       child: Divider(
//                         color: Color(0xff01B8FA),
//                         height: 2,
//                         thickness: 3,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding:
//                     EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(left: 20, right: 20, top: 20),
//                         child: Text(
//                           'Add New Product',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontStyle: FontStyle.italic,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff3C3E89),
//                           ),
//                         ),
//                       ),
//                       // Image Picker
//                       GestureDetector(
//                         onTap: _pickImage,
//                         child: Container(
//                           height: 100,
//                           width: 100,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             image: _image != null
//                                 ? DecorationImage(
//                                     image: FileImage(_image!),
//                                     fit: BoxFit.cover,
//                                   )
//                                 : DecorationImage(
//                                     image: NetworkImage(
//                                         "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"),
//                                     fit: BoxFit.cover,
//                                   ),
//                           ),
//                         ),
//                       ),
//                       // Form Fields
//                       Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             // Product Name
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 labelText: "Product Name",
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.blueAccent),
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter product name';
//                                 }
//                                 return null;
//                               },
//                               onChanged: (value) {
//                                 productName = value;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             // Description
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 labelText: "Description",
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.blueAccent),
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter description';
//                                 }
//                                 return null;
//                               },
//                               onChanged: (value) {
//                                 description = value;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             // Net Quantity
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 labelText: "Net Quantity",
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.blueAccent),
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter net quantity';
//                                 }
//                                 return null;
//                               },
//                               onChanged: (value) {
//                                 netQuantity = value;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             // Weight
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 labelText: "Weight",
//                                 hintText: "0g/ Kg",
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.blueAccent),
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter weight';
//                                 }
//                                 return null;
//                               },
//                               onChanged: (value) {
//                                 weight = value;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             // Packing Type
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 labelText: "Packing Type",
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: Colors.blueAccent),
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter packing type';
//                                 }
//                                 return null;
//                               },
//                               onChanged: (value) {
//                                 packingType = value;
//                               },
//                             ),
//                             SizedBox(height: 20),
//                             // Added Date
//                             GestureDetector(
//                               onTap: _showDatePicker,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Added Date: $addedDate',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xff3C3E89),
//                                     ),
//                                   ),
//                                   Icon(
//                                     Icons.calendar_today,
//                                     color: Color(0xff3C3E89),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             // Submit and Cancel Buttons
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     Get.back();
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       color: Color(0xffff8800),
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Text(
//                                       'Cancel',
//                                       style: TextStyle(
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: _submit,
//                                   child: Container(
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       color: Color(0xff01b8fa),
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Text(
//                                       'Submit',
//                                       style: TextStyle(
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
