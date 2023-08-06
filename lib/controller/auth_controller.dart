import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pppcalculator/model/user.dart';
import 'package:pppcalculator/view/screens/auth/loging_stage.dart';
import 'package:pppcalculator/view/screens/calculator/home.dart';
import 'package:pppcalculator/view/screens/auth/signup_screen.dart';

import 'package:pppcalculator/model/aync_response.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  File? proimg;

  Future<String> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final img = File(image!.path);
    this.proimg = img;
    return image.path;
  }

  late Rx<User?> _user;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    FirebaseAuth.instance.currentUser?.reload();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);
  }

  _setInitialView(User? user) {
    if (user == null) {
      Get.offAll(() => LoginStage());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  //User Register

  Future<AsyncResponseStatus> SignUp(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = "";
        if (image != null) {
          downloadUrl = await _uploadProPic(image);
        }
        myUser user = myUser(
            name: username,
            email: email,
            profilePhoto: downloadUrl,
            uid: credential.user!.uid);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
        return AsyncResponseStatus(success: true, errorTitle: "", errorDesc: "");
      } else {
        // Get.snackbar("Error", "All fields are mandatory");
        return AsyncResponseStatus(success: false, errorTitle: "Error", errorDesc: "All fields are mandatory");
      }
    } catch (e) {
      print(e);
      // Get.snackbar("Error Occurred", e.toString());
      return AsyncResponseStatus(success: false, errorTitle: "Error", errorDesc: e.toString());
    }
  }

  Future<String> _uploadProPic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();
    return imageDwnUrl;
  }

  void goToLogin() async {
    Get.offAll(() => SignUpScreen());
  }

  Future<AsyncResponseStatus> login(String email, String password) async {
    AsyncResponseStatus _asyncResponseStatus = AsyncResponseStatus(success: false, errorTitle: "", errorDesc: "");
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        _asyncResponseStatus.success = true;
        return _asyncResponseStatus;
      } else {
        _asyncResponseStatus.success = false;
        _asyncResponseStatus.errorTitle = "Error In Login.";
        _asyncResponseStatus.errorDesc = "Username & Password are required!";
        return _asyncResponseStatus;
      }
    } catch (e) {
      // Get.snackbar("Error Logging In", e.toString());
      _asyncResponseStatus.success = false;
      _asyncResponseStatus.errorTitle = "Error In Login.";
      _asyncResponseStatus.errorDesc = e.toString();
      return _asyncResponseStatus;
    }
  }
}
