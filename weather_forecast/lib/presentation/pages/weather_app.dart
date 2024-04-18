import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

const weatherApiUrl = 'https://api.openweathermap.org/data/2.5/forecast';
const apiKey = '2e9714911e1deb0a2ee62104c0b5928b';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('Error getting location: $e');
      // Providing default location (New York City coordinates)
      latitude = 40.7128;
      longitude = -74.0060;
    }
  }
}

class NetworkData {
  NetworkData(this.url);
  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load data');
    }
  }
}

class Temperature {
  final double celsius;

  Temperature({required this.celsius});
}

class Weather {
  final DateTime date;
  final Temperature temperature;

  Weather({required this.date, required this.temperature});
}

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$weatherApiUrl?q=$cityName&appid=$apiKey&units=metric';
    NetworkData networkHelper = NetworkData(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  Future<List<Weather>> getFiveDayForecast(double latitude, double longitude) async {
    var url = '$weatherApiUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    NetworkData networkHelper = NetworkData(url);
    var weatherData = await networkHelper.getData();
    List<Weather> forecastList = _parseForecastData(weatherData);
    return forecastList;
  }

  List<Weather> _parseForecastData(dynamic weatherData) {
    List<Weather> forecastList = [];
    List<dynamic> forecastDataList = weatherData['list'];
    for (var forecastData in forecastDataList) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(forecastData['dt'] * 1000);
      double temp = forecastData['main']['temp'].toDouble();
      Weather weather = Weather(date: dateTime, temperature: Temperature(celsius: temp));
      forecastList.add(weather);
    }
    return forecastList;
  }
}
