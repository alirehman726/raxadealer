// import 'dart:convert';
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

//   Future<void> doCallAPILogin(String status) async {
//     doStartLoader(true);

//     dio.FormData body = dio.FormData.fromMap({
//       "ads_id": widget.id, // Ensure you have the correct id
//       'status': status.toString(),
//     });

//     body.fields.forEach((field) {
//       print("${field.key}: ${field.value}");
//     });

//     var res = await AuthApis.changeStatus(body);

//     if (res != null) {
//       Map<String, dynamic> response = json.decode(res.toString());
//       print(response);
//       print(response['status']);
//       print('Hello TVS');
//       if (response['status'] == true) {
//         print('Rehmanali');
//         print(response['message']);
//         doStartLoader(false);
//         SnackbarCustom.success("Success", response['message'].toString());

//         Get.offAll(() => ScreenAds());

//         final controllerAllAds = Get.find<ControllerAllAds>();

//         await controllerAllAds.controllerAllAds();
//         controllerAllAds.update();
//       } else {
//         doStartLoader(false);
//         SnackbarCustom.error("Error", response['message']);
//       }
//     } else {
//       doStartLoader(false);
//       SnackbarCustom.error("Error",
//           "Unable to login at the moment. Please try again after sometime.");
//     }
//   }

//   void _submit() {
//     if (_formKey.currentState!.validate()) {
//       // If the form is valid, call the API
//       doCallAPILogin(selectedValue); // Pass the status you want to send
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Color(0xffccf1fe),
//       appBar: AppBar(
//         title: Text("Add PRODUCT"),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Your existing form fields go here
//               // Example for Product Name
//               TextFormField(
//                 decoration: InputDecoration(labelText: "Product Name"),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter product name';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   productName = value;
//                 },
//               ),
//               // Add other fields similarly...

//               // Submit Button
//               ElevatedButton(
//                 onPressed: _submit,
//                 child: Text("Submit"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
