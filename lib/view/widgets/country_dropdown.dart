import 'package:flutter/material.dart';

// const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class CountryDropDown extends StatefulWidget {
  final String selctedCountry;
  final List<String> list;
  const CountryDropDown({Key? key,required this.selctedCountry, required this.list}) : super(key: key);

  @override
  State<CountryDropDown> createState() => _CountryDropDown();
}

class _CountryDropDown extends State<CountryDropDown> {
  String dropdownValue = "";
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
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
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
