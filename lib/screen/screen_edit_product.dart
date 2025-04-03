import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/Controller/controller_allProducts.dart';
import 'package:raxaadmin/Model/ModelAllProducts.dart';
import 'package:raxaadmin/screen/screen_product.dart';
import 'package:raxaadmin/utils/images.dart';

class ScreenEditProduct extends StatefulWidget {
  final AllProducts product;
  const ScreenEditProduct({super.key, required this.product});

  @override
  State<ScreenEditProduct> createState() => _ScreenEditProductState();
}

class _ScreenEditProductState extends State<ScreenEditProduct> {
  // String selectedValue = "Yes";
  // List<String> options = ["Yes", "No"];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController packingTypeController = TextEditingController();
  final TextEditingController flavourTypeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String selectedStock = "yes";
  File? _image;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.productName;
    descriptionController.text = widget.product.discription;
    priceController.text = widget.product.price.toString();
    quantityController.text = widget.product.quantity.toString();
    weightController.text = widget.product.weight;
    packingTypeController.text = widget.product.packingType;
    flavourTypeController.text = widget.product.flavour;
    // dateController.text = widget.product.addedDate ?? '';
    selectedStock = widget.product.stock ?? "yes";

    print("Stock from API: ${widget.product.stock.runtimeType}");

    // Debugging: Print the stock value
    print("API Response Stock Value: ${widget.product.stock}");
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String addedDate = 'Select Date';

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
  // void _showDatePicker() async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );

  //   if (pickedDate != null) {
  //     setState(() {
  //       addedDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
  //       dateController.text = addedDate;
  //     });
  //   }
  // }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse(
          "https://raxaspread.com/API/api/edit_product/${widget.product.id}");
      var request = http.MultipartRequest('POST', url);

      request.fields['product_name'] = nameController.text;
      request.fields['discription'] = descriptionController.text;
      request.fields['price'] = priceController.text;
      request.fields['quantity'] = quantityController.text;
      request.fields['stock'] = selectedStock;
      request.fields['weight'] = weightController.text;
      request.fields['packing_type'] = packingTypeController.text;
      request.fields['flavour'] = flavourTypeController.text;

      if (_image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', _image!.path));
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("Response Code: ${response.statusCode}");
      print("Response Body: $responseBody");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(responseBody);
        if (jsonResponse['status'] == true) {
          Fluttertoast.showToast(msg: jsonResponse['message'].toString());
          Get.offAll(() => ScreenProduct());

          final controllerAllProducts = Get.find<ControllerAllproducts>();
          await controllerAllProducts.controllerAllProducts();
          controllerAllProducts.update();
        } else {
          Fluttertoast.showToast(msg: jsonResponse['message'].toString());
        }
      } else {
        Get.snackbar("Error", "Failed to update product");
      }
    }
  }

  void deleteItem(int id) async {
    var res = await AuthApis.deleteOrderApi(id);

    if (res != null) {
      Map<String, dynamic> response = json.decode(res.toString());

      if (response['status'] == true) {
        Fluttertoast.showToast(msg: response['message'].toString());
        Get.offAll(() => ScreenProduct());

        final controllerAllProducts = Get.find<ControllerAllproducts>();
        await controllerAllProducts.controllerAllProducts();
        controllerAllProducts.update();

        // ✅ UI अपडेट करो
        setState(() {
          isLoading = false;
        });

        print("✅ Data refreshed successfully!");
        // if (controllerAllProducts.controllerAllProducts) {
        //   Get.back(); // ✅ Model Close
        // }
      } else {
        setState(() {
          isLoading = false;
        });

        Fluttertoast.showToast(msg: response['message'].toString());
        // SnackbarCustom.error("Error", response['message']);
      }
    } else {
      throw Exception("No Response from API");
    }
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
              "Edit PRODUCT",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Product',
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
                  InkWell(
                    onTap: () {
                      Get.dialog(
                        AlertDialog(
                          title: Text('Are You Sure You Want To Delete'),
                          //content: Text("This should not be closed automatically"),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () async {
                                // Get.dialog(
                                //   // Container(
                                //   //   child: Center(
                                //   //     child: CircularProgressIndicator(
                                //   //       color: darkButtonColor,
                                //   //     ),
                                //   //   ),
                                //   // ),
                                //   barrierDismissible: false,
                                // );
                                deleteItem(widget.product.id);
                              },
                            ),
                            TextButton(
                              child: Text('No'),
                              onPressed: () {
                                Get.back();
                              },
                            )
                          ],
                        ),
                        barrierDismissible: false,
                      );
                    },
                    child: Icon(Icons.delete_outline_rounded,
                        color: Colors.red, size: 30),
                  ),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Text(
                          'Edit Product',
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
                            GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  image: _image == null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              widget.product.image),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: FileImage(_image!),
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Edit Product',
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Product Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900],
                                ),
                              ),
                            ),
                            // TextField(
                            //   decoration: InputDecoration(
                            //     hintText: "JPSR Prabhu Shriram Agarbatti",
                            //     hintStyle:
                            //         TextStyle(fontWeight: FontWeight.bold),
                            //     enabledBorder: UnderlineInputBorder(
                            //       borderSide:
                            //           BorderSide(color: Colors.blueAccent),
                            //     ),
                            //   ),
                            // ),
                            TextFormField(
                              controller: nameController,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter product name" : null,
                              decoration: InputDecoration(
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Discrption",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900],
                                ),
                              ),
                            ),
                            // TextField(
                            //   obscureText: true,
                            //   decoration: InputDecoration(
                            //     hintText:
                            //         "JPSR Prabhu Shriram Agarbatti Perfume incense sticks....",
                            //     enabledBorder: UnderlineInputBorder(
                            //       borderSide:
                            //           BorderSide(color: Colors.blueAccent),
                            //     ),
                            //   ),
                            // ),
                            TextFormField(
                              controller: descriptionController,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter description" : null,
                              decoration: InputDecoration(
                                hintText: "",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                ),
                              ),
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
                                      child: DropdownButtonFormField<String>(
                                        value:
                                            selectedStock, // Ensure this holds "yes" or "no"
                                        items:
                                            ["yes", "no"].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                                value), // Show API value properly
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedStock = newValue!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            labelText: selectedStock),
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
                                        controller: quantityController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) => value!.isEmpty
                                            ? "Enter quantity"
                                            : null,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      ),
                                      // child: TextField(
                                      //   decoration: InputDecoration(
                                      //     hintText: "50",
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
                                        controller: weightController,
                                        validator: (value) => value!.isEmpty
                                            ? "Enter weight"
                                            : null,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      ),
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
                                        controller: packingTypeController,
                                        validator: (value) => value!.isEmpty
                                            ? "Enter packing type"
                                            : null,
                                        decoration: InputDecoration(
                                          hintText: "Round",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent),
                                          ),
                                        ),
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
                                        controller: flavourTypeController,
                                        validator: (value) => value!.isEmpty
                                            ? "Enter Flavour"
                                            : null,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent),
                                          ),
                                        ),
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
                                        controller: priceController,
                                        validator: (value) => value!.isEmpty
                                            ? "Enter Price"
                                            : null,
                                        decoration: InputDecoration(
                                          hintText: "",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blueAccent),
                                          ),
                                        ),
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
                            //     // Text(
                            //     //   ' 31/02/2025 ',
                            //     //   style: TextStyle(
                            //     //     fontSize: 12,
                            //     //     fontWeight: FontWeight.bold,
                            //     //     color: Color(0xff3C3E89),
                            //     //   ),
                            //     // ),
                            //     TextFormField(
                            //       onTap: _showDatePicker,
                            //       controller: dateController,
                            //       readOnly:
                            //           true, // <-- Isko true rakhein taki user change na kar sake
                            //       decoration: InputDecoration(
                            //         // labelText: "Added Date",
                            //         suffixIcon: Icon(
                            //           Icons.calendar_month_outlined,
                            //           color: Color(0xff3C3E89),
                            //         ),
                            //       ),
                            //     ),
                            //     // const SizedBox(width: 10),
                            //     // Icon(
                            //     //   Icons.calendar_month_outlined,
                            //     //   color: Color(0xff3C3E89),
                            //     // )
                            //   ],
                            // ),

                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: TextFormField(
                            //         onTap: _showDatePicker,
                            //         controller: dateController,
                            //         readOnly:
                            //             true, // <-- Isko true rakhein taki user change na kar sake
                            //         decoration: InputDecoration(
                            //           labelText: "Added Date",
                            //           suffixIcon: Icon(
                            //             Icons.calendar_month_outlined,
                            //             color: Color(0xff3C3E89),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
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
                                InkWell(
                                  onTap: () {
                                    // Get.back();
                                    _updateProduct();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
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
            ),
          ],
        ),
      ),
    );
  }
}
