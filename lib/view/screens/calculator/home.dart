import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pppcalculator/controller/auth_controller.dart';
import 'package:pppcalculator/controller/data_controller.dart';

import 'package:pppcalculator/view/widgets/country_dropdown.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String defaultSelectedCountry = "";
  late List<String> countries = [];
  @override
  void initState() {
    // defaultSelectedCountry = "Two";
    EasyLoading.show(status: 'Updating...');
    var dataCountries = <String>[];
    print('initState');
    DataController.instance.fetchCountryList().then((value) {
      for(final e in value){
        var currentElement = e.toJson()["value"];
        dataCountries.add(currentElement);
        print('Async done ' + currentElement);
      }
      setState(() {
        countries = dataCountries;
        defaultSelectedCountry = countries.first;
        EasyLoading.dismiss();
      });


    }).catchError((onError) {
      setState(() {
        countries = [""];
        defaultSelectedCountry = "";
        EasyLoading.dismiss();
      });
      print('Async error '+ onError.toString());
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
        // actions: const [
        //   Icon(Icons.outbond_outlined),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(
                height: 25,
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child:  CountryDropDown(
                  selctedCountry: defaultSelectedCountry,
                  list: countries,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child:  CountryDropDown(
                    selctedCountry: defaultSelectedCountry,
                    list: countries,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child:  CountryDropDown(
                  selctedCountry: defaultSelectedCountry,
                  list: countries,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child:  CountryDropDown(
                  selctedCountry: defaultSelectedCountry,
                  list: countries,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}