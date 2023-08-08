import 'dart:convert';

List<CountryListObject> countriesFromJson(String str) {
  final jsonData = json.decode(str);
  return List<CountryListObject>.from(
      jsonData.map((x) => CountryListObject.fromJson(x)));
}

class CountryListObject {
  final String country;
  final String value;

  const CountryListObject({
    required this.country,
    required this.value,
  });

  Map<String, dynamic> toJson() => {"country": country, "value": value};

  factory CountryListObject.fromJson(Map<String, dynamic> json) {
    return CountryListObject(
      country: json['country'],
      value: json['value'],
    );
  }
}
