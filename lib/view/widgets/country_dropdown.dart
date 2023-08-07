import 'package:flutter/material.dart';

class CountryDropDown extends StatefulWidget {
  final String selctedCountry;
  final List<String> list;
  final Function(String) onCountryChanged;

  const CountryDropDown(
      {super.key,
      required this.selctedCountry,
      required this.list,
      required this.onCountryChanged});

  @override
  State<CountryDropDown> createState() => _CountryDropDown();
}

class _CountryDropDown extends State<CountryDropDown> {
  String dropdownValue = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selctedCountry,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      isExpanded: true,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        widget.onCountryChanged(value!);
        // setState(() {
        //   dropdownValue = value!;
        // });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
