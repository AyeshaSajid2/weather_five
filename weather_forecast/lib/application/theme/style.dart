import 'package:flutter/material.dart';
import 'package:weather_forecast/application/theme/colors.dart';

const NumberTextStyle = TextStyle(fontSize: 50, fontWeight: FontWeight.w600);

const normalTextStyle = TextStyle(
  fontSize: 30.0,
);

const subTitleTextStyle = TextStyle(fontSize: 25.0, color: white2);

const titleTextStyle =
    TextStyle(fontSize: 40.0, color: white, fontWeight: FontWeight.bold);

const resultTextStyle = TextStyle(
    fontSize: 40.0, color: hourbourGreen, fontWeight: FontWeight.bold);

const bmiResultTextStyle =
    TextStyle(fontSize: 90.0, color: white, fontWeight: FontWeight.bold);
const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 40.0,
);

const kButtonTextStyle =
    TextStyle(fontSize: 30.0, fontFamily: 'Spartan MB', color: white);

const kConditionTextStyle = TextStyle(
  fontSize: 80.0,
);

const textFieldDecoration = InputDecoration(
    filled: true,
    fillColor: white,
    icon: Icon(
      Icons.local_activity,
      color: white,
    ),
    hintText: 'Enter City name',
    hintStyle: TextStyle(color: black),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide.none,
    ));
