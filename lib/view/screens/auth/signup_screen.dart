import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:pppcalculator/controller/auth_controller.dart';
import 'package:pppcalculator/view/widgets/glitch.dart';
import 'package:pppcalculator/view/widgets/text_input.dart';
import '../../widgets/dynamic_file.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // SignUpScreen({Key? key}) : super(key: key);
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _setpasswordController = new TextEditingController();
  TextEditingController _confirmpasswordController =
      new TextEditingController();
  File file = File('assets/images/blank_avatar.jpg');
  late bool imageSelected = false;
  late String imgPicked = "";

  @override
  initState() {
    imageSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlithEffect(
                  child: const Text(
                "PPP Calculator",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              )),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () async {
                  // EasyLoading.instance
                  //   ..loadingStyle = EasyLoadingStyle.custom //This was missing in earlier code
                  //   ..backgroundColor = Colors.white
                  //   ..textColor = Colors.black
                  //   ..indicatorColor = Colors.green;

                  // EasyLoading.show(status: 'Uploading...');
                  imgPicked = await AuthController.instance.pickImage();
                  // EasyLoading.dismiss();
                  setState(() {
                    imageSelected = true;
                  });
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: imageSelected
                          ? Image.file(File(imgPicked)).image
                          : AssetImage('assets/images/blank_avatar.jpg'),
                      radius: 60,
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.black,
                            )))
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _emailController,
                  myLabelText: "Email",
                  myIcon: Icons.email,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _setpasswordController,
                  myLabelText: "Set Password",
                  myIcon: Icons.lock,
                  toHide: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _confirmpasswordController,
                  myLabelText: "Confirm Password",
                  myIcon: Icons.lock,
                  toHide: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _usernameController,
                  myLabelText: "Username",
                  myIcon: Icons.person,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              OutlinedButton(
                  onPressed: () async {
                    EasyLoading.instance
                      ..loadingStyle = EasyLoadingStyle.custom //This was missing in earlier code
                      ..backgroundColor = Colors.white
                      ..textColor = Colors.black
                      ..indicatorColor = Colors.green;

                    EasyLoading.show(status: 'Signing In...');

                    var stst = await AuthController.instance.SignUp(
                        _usernameController.text,
                        _emailController.text,
                        _setpasswordController.text,
                        AuthController.instance.proimg);

                    EasyLoading.dismiss();

                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1.0, color: Colors.white),
                  ),
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.of(context).size.width - 100,
                      child: Text("Sign Up", textAlign: TextAlign.center))),
              SizedBox(
                height: 10,
              ),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1.0, color: Colors.white),
                  ),
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.of(context).size.width - 100,
                      child: Text("Alrady have account? Log in",
                          textAlign: TextAlign.center))),
            ],
          ),
        ),
      ),
    );
  }
}
