import 'package:http/http.dart' as http;

import 'package:pppcalculator/model/country_list.dart';
import 'package:pppcalculator/constants.dart' as Constants;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pppcalculator/model/final_result.dart';

class DataController {
  // static DataController instance = Get.find();

  DataController._privateConstructor();

  static final DataController _instance = DataController._privateConstructor();

  static DataController get instance => _instance;

  //
  // void goToAbout() async {
  //   GoRouter.of(context).push(Uri(path: '/about').toString());
  // }
  //
  // void goToHome() async {
  //   GoRouter.of(context).push(Uri(path: '/home').toString());
  // }

  Future<List<CountryListObject>> fetchCountryList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? countryList = prefs.getString(Constants.CountryListLocalKey);

    if (countryList != null) {
      return countriesFromJson(countryList);
    }

    String countryListMethod = Constants.CountryListMethod;
    String url = Constants.ServerURL;
    String URLForCountryList = '$url?$countryListMethod';
    final response = await http.get(Uri.parse(URLForCountryList));
    if (response.statusCode == 200) {
      if (countryList == null) {
        await prefs.setString('fetchCountryList', response.body);
      }
      return countriesFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<FinalResult> fetchResult(String selectedTargetCountry, String selectedSourceCountry, String amount) async {
    if(amount == "") {
      amount = "0";
    }
    String calculateMethod = Constants.CalulateResultMethod;
    String url = Constants.ServerURL;
    String URLForCalculation = '$url?$calculateMethod&sourceAmount=$amount&sourceCountry=$selectedSourceCountry&targetCountry=$selectedTargetCountry';
    final response = await http.get(Uri.parse(URLForCalculation));
    if (response.statusCode == 200) {
      return FinalResult.fromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
