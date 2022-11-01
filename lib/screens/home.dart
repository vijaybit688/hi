import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String phoneCode = "91";
String phoneNumber = "";
String message = "";
String displayName = "India";

TextEditingController phoneNumberController = TextEditingController();
TextEditingController messageController = TextEditingController();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 100.0, bottom: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: IconButton(
                      onPressed: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode:
                              true, // optional. Shows phone code before the country name.
                          onSelect: (Country country) {
                            print('Select country: ${country.phoneCode}');
                            setState(() {
                              phoneCode = country.phoneCode;
                              displayName = country.displayName.split('(')[0];
                            });
                          },
                        );
                      },
                      icon: Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 45,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
                  Text(
                    "$phoneCode $displayName",
                    style: TextStyle(color: Colors.white, fontSize: 21),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink)),
                          label: Text("Phone Number")),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                child: TextField(
                  controller: messageController,
                  maxLines: null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      label: Text("Message")),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(10)),
                width: 120,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 24,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (!await launch(
                              "https://wa.me/$phoneCode${phoneNumberController.text}?text=${messageController.text}"))
                            throw 'Could not launch ';
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              const Text(
                "Please Select Correct Country Code",
                style: TextStyle(fontSize: 22, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
