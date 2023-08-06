import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pppcalculator/controller/auth_controller.dart';
import 'package:pppcalculator/view/widgets/glitch.dart';
import 'package:pppcalculator/view/widgets/text_input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlithEffect(
                child: const Text(
              "PPP Calculator",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            )),
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
                controller: _passwordController,
                myLabelText: "Password",
                myIcon: Icons.lock,
                toHide: true,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            OutlinedButton(
                onPressed: () async {
                  EasyLoading.instance
                    ..loadingStyle = EasyLoadingStyle
                        .custom //This was missing in earlier code
                    ..backgroundColor = Colors.white
                    ..textColor = Colors.black
                    ..indicatorColor = Colors.green;

                  EasyLoading.show(status: 'Authenticating...');
                  var stst = await AuthController.instance
                      .login(_emailController.text, _passwordController.text);

                  EasyLoading.dismiss();

                  if (stst.success) {
                    EasyLoading.showToast('Conratulations Login Successful');
                  } else {
                    EasyLoading.showToast('Login Failed');
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1.0, color: Colors.white),
                ),
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text("Login", textAlign: TextAlign.center))),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
                onPressed: () {
                  AuthController.instance.goToLogin();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1.0, color: Colors.white),
                ),
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text("Register", textAlign: TextAlign.center)))
          ],
        ),
      ),
    );
  }
}
