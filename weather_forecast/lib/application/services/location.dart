import 'dart:convert';
import 'package:http/http.dart' as http; // Add this import statement

import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude; // Corrected the typo in the variable name
  late String apiKey = '2e9714911e1deb0a2ee62104c0b5928b';
  late int status;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getData() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));

      String data = response.body;
      var decode = jsonDecode(data);

      var id = decode['weather'][0]['id'];
      print(id);

      var temp = decode['main']['temp'];
      print(temp);

      var city = decode['name'];
      print(city);

      response.statusCode == 200
          ? print(response.body)
          : print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }
}

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future<void> getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      String data = response.body;

      response.statusCode == 200
          ? print(jsonDecode(data))
          : print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }
}
