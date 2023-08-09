import 'package:dropdown_search/dropdown_search.dart';
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
    return DropdownSearch<String>(
      popupProps: const PopupProps.menu(
        showSearchBox: true,
        showSelectedItems: true,
        // disabledItemFn: (String s) => s.startsWith('I'),
      ),
      items: widget.list,
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          // labelText: "Menu mode",
          hintText: "Select Country",
        ),
      ),
      onChanged: (String? value) {
        widget.onCountryChanged(value!);
        // setState(() {
        //   dropdownValue = value!;
        // });
      },
      selectedItem: widget.selctedCountry,
    );
  }
}
