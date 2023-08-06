import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pppcalculator/controller/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter App",
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () async {
              SystemNavigator.pop();
              var stst = await AuthController.instance.SignOutUser();
            },
          ),
          // Icon(Icons.arrow_back),
          title: Text("PPP Calculator"),
          backgroundColor: Colors.black45,
          // actions: [
          //   Icon(Icons.outbond_outlined),
          // ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Center(
            child: new Text("Hello World."),
          ),
        ),
      ),
    );
  }
}
