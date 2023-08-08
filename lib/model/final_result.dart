import 'dart:convert';

class FinalResult {
  String sourceAmount;
  String sourceCountry;
  String targetAmount;
  String targetCountry;
  List<CountryAbbrevation> sourceCountryAbbr;
  List<CountryAbbrevation> targetCountryAbbr;

  FinalResult({
    required this.sourceAmount,
    required this.sourceCountry,
    required this.targetAmount,
    required this.targetCountry,
    required this.sourceCountryAbbr,
    required this.targetCountryAbbr,
  });

  Map<String, dynamic> toJson() => {
        "sourceAmount": sourceAmount,
        "sourceCountry": sourceCountry,
        "targetAmount": targetAmount,
        "targetCountry": targetCountry,
        "sourceCountryAbbr": sourceCountryAbbr,
        "targetCountryAbbr": targetCountryAbbr
      };

  factory FinalResult.fromJson(dynamic json) {
    List<CountryAbbrevation> _sourceCountryAbbr = [
      CountryAbbrevation.fromJson(jsonDecode(json)['sourceCountryAbbr'][0]),
    ];
    List<CountryAbbrevation> _targetCountryAbbr = [
      CountryAbbrevation.fromJson(jsonDecode(json)['targetCountryAbbr'][0]),
    ];

    return FinalResult(
      sourceAmount: jsonDecode(json)['sourceAmount'],
      sourceCountry: jsonDecode(json)['sourceCountry'],
      targetAmount: jsonDecode(json)['targetAmount'],
      targetCountry: jsonDecode(json)['targetCountry'],
      sourceCountryAbbr: _sourceCountryAbbr,
      targetCountryAbbr: _targetCountryAbbr,
    );
  }
}

class CountryAbbrevation {
  String country;
  String currency_code;
  String currency_name;

  CountryAbbrevation(
      {required this.country,
      required this.currency_code,
      required this.currency_name});

  Map<String, dynamic> toJson() => {
        "country": country,
        "currency_code": currency_code,
        "currency_name": currency_name
      };

  factory CountryAbbrevation.fromJson(dynamic json) {
    return CountryAbbrevation(
      currency_name: json['currency_name'],
      currency_code: json['currency_code'],
      country: json['country'],
    );
  }
}
