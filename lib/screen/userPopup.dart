import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserFormPopup extends StatefulWidget {
  @override
  _UserFormPopupState createState() => _UserFormPopupState();
}

class _UserFormPopupState extends State<UserFormPopup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchCities();
  }

  List<dynamic> cities = [];

  String? selectedCity;
  Future<void> fetchCities() async {
    final response =
        await http.get(Uri.parse('https://raxaspread.com/API/api/get-city'));
    if (response.statusCode == 200) {
      print(response.body);
      print("kjcbhwsjkchew");
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> cityList = jsonResponse['data'];

      setState(() {
        cities = cityList;
      });
    } else {
      print("Failed to load cities");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: Colors.white,
        // title: Text('User Form'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Field
                // TextFormField(
                //   controller: _nameController,
                //   decoration: InputDecoration(
                //     labelText: 'Name',
                //   ),
                //   validator: (value) =>
                //       value == null || value.isEmpty ? 'Enter your name' : null,
                // ),
                Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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

                SizedBox(height: 16),

                Text(
                  "City",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
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
                    labelText: "Please select city",
                    filled: true,
                    fillColor: Colors.white,
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
              ],
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();

                sharedPreferences.setString(
                  "name",
                  _nameController.text,
                );
                sharedPreferences.setString(
                  "city_id",
                  selectedCity!,
                );

                Navigator.pop(context);

                // Optional: Show confirmation
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text('Form submitted!')),
                // );
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: 80,
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
      ),
    );
  }
}
