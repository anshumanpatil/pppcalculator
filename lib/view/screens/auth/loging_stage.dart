import 'package:flutter/material.dart';
import 'package:pppcalculator/view/screens/auth/login_screen.dart';
import 'package:pppcalculator/view/screens/calculator/home.dart';
import 'package:pppcalculator/view/widgets/custom_outlined_btn.dart';

class LoginStage extends StatelessWidget {
  const LoginStage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomOutlinedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              myLabelText: "Use Without Login",
            ),
            SizedBox(
              height: 15,
            ),
            CustomOutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              myLabelText: "Login With Email",
            ),
          ],
        ),
      ),
    );
  }
}
