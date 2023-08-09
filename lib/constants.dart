import 'dart:math';

import 'package:flutter/material.dart';

getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][Random().nextInt(3)];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

const String ServerURL = "https://pppcalculator-api.onrender.com/pppdata";
const String CountryListMethod="method=countries";
const String CalulateResultMethod="method=calculate";
const String CountryListLocalKey="fetchCountryList";
const String APP_TITLE="PPP Calculator";
