import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:pppcalculator/model/country_list.dart';
import 'package:pppcalculator/constants.dart' as Constants;


class DataController extends GetxController {
  static DataController instance = Get.find();

  Future<List<CountryListObject>> fetchCountryList() async {
    DateTime now = DateTime.now();
    String countryListMethod = Constants.CountryListMethod;
    String url = Constants.ServerURL;
    String URLForCountryList = '$url?$countryListMethod';
    final response = await http.get(Uri.parse(URLForCountryList));
    if (response.statusCode == 200) {
      return countriesFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }


}
