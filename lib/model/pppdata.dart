class PPPData {
  final String countryiso3code;
  final String date;

  const PPPData({
    required this.countryiso3code,
    required this.date,
  });
  Map<String, dynamic> toJson() =>
      {"date": date, "countryiso3code": countryiso3code};
  factory PPPData.fromJson(Map<String, dynamic> json) {
    return PPPData(
      date: json['date'],
      countryiso3code: json['countryiso3code'],
    );
  }
}
