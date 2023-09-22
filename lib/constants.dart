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

const String ServerURL = "https://qiy757a2c6ytdbqewmh5a7ofji0odvru.lambda-url.eu-north-1.on.aws";
const String CountryListMethod="method=countries";
const String CalulateResultMethod="method=calculate";
const String CountryListLocalKey="fetchCountryList";
const String APP_TITLE="PPP Calculator";
