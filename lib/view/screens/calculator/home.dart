import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pppcalculator/controller/auth_controller.dart';
import 'package:pppcalculator/controller/data_controller.dart';
import 'package:pppcalculator/view/widgets/country_dropdown.dart';
import 'package:pppcalculator/view/widgets/text_input.dart';
import 'package:pppcalculator/view/widgets/result_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String selectedSourceCountry = "";
  late String selectedTargetCountry = "";

  late String targetAmount = "";
  late String sourceAmount = "";

  late List<String> countries = [];
  final TextEditingController _amountController = TextEditingController();
  late bool isResultVisible = false;

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
      print('Async error $onError');
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
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('PPP Calculator'),
              content: const Text('Do You want to exit ?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    SystemNavigator.pop();
                    var stst = await AuthController.instance.SignOutUser();
                  },
                  child: const Text('Exit'),
                ),
              ],
            ),
          ),
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
                  controller: _amountController,
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
                      isResultVisible = false;
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
                      isResultVisible = false;
                      selectedTargetCountry = v;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                  onPressed: () async {
                    EasyLoading.instance
                      ..loadingStyle = EasyLoadingStyle
                          .custom //This was missing in earlier code
                      ..backgroundColor = Colors.white
                      ..textColor = Colors.black
                      ..indicatorColor = Colors.green;

                    EasyLoading.show(status: 'Calculating...');

                    var result = await DataController.instance.fetchResult(
                        selectedTargetCountry,
                        selectedSourceCountry,
                        _amountController.text);
                    EasyLoading.dismiss();
                    setState(() {
                      if (!isResultVisible) {
                        isResultVisible = true;
                        selectedTargetCountry = result.targetCountry;
                        selectedSourceCountry = result.sourceCountry;
                        sourceAmount =
                            '${_amountController.text} ${result.sourceCountryAbbr[0].currency_code}';
                        targetAmount =
                            '${result.targetAmount} ${result.targetCountryAbbr[0].currency_code}';
                      }
                    });
                    print(result.toJson());
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1.0, color: Colors.white),
                  ),
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.of(context).size.width - 100,
                      child: const Text("Calculate",
                          textAlign: TextAlign.center))),
              const SizedBox(
                height: 20,
              ),
              ResultText(
                selectedSourceCountry: selectedSourceCountry,
                selectedTargetCountry: selectedTargetCountry,
                sourceAmount: targetAmount,
                targetAmount: sourceAmount,
                isVisible: isResultVisible,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
