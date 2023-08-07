import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pppcalculator/controller/auth_controller.dart';
import 'package:pppcalculator/controller/data_controller.dart';

import 'package:pppcalculator/view/widgets/country_dropdown.dart';

import '../../widgets/text_input.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late String defaultSelectedCountry = "";

  late String selectedSourceCountry = "";
  late String selectedTargetCountry = "";
  late List<String> countries = [];
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    // defaultSelectedCountry = "Two";
    EasyLoading.show(status: 'Updating...');
    var dataCountries = <String>[];
    print('initState');
    DataController.instance.fetchCountryList().then((value) {
      for (final e in value) {
        var currentElement = e.toJson()["value"];
        dataCountries.add(currentElement);
        // print('Async done ' + currentElement);
      }
      setState(() {
        countries = dataCountries;
        selectedSourceCountry = countries.first;
        selectedTargetCountry = countries.first;
        EasyLoading.dismiss();
      });
    }).catchError((onError) {
      setState(() {
        countries = [""];
        selectedSourceCountry = "";
        selectedTargetCountry = "";
        EasyLoading.dismiss();
      });
      print('Async error ' + onError.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () async {
            SystemNavigator.pop();
            var stst = await AuthController.instance.SignOutUser();
          },
        ),
        // Icon(Icons.arrow_back),
        title: const Text("PPP Calculator"),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _emailController,
                  myLabelText: "Current Income",
                  myIcon: Icons.monetization_on_outlined,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Source Country",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.deepPurple),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 33),
                child: CountryDropDown(
                  selctedCountry: selectedSourceCountry,
                  list: countries,
                  onCountryChanged: (String v) {
                    setState(() {
                      selectedSourceCountry = v;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Target Country",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.deepPurple),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 33),
                // padding: const EdgeInsets.symmetric(vertical: 15),
                child: CountryDropDown(
                  selctedCountry: selectedTargetCountry,
                  list: countries,
                  onCountryChanged: (String v) {
                    setState(() {
                      selectedTargetCountry = v;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                  onPressed: () async {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1.0, color: Colors.white),
                  ),
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.of(context).size.width - 100,
                      child: const Text("Calculate",
                          textAlign: TextAlign.center))),
            ],
          ),
        ),
      ),
    );
  }
}
