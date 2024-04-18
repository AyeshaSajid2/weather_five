
import 'package:flutter/cupertino.dart';
import 'package:weather/weather.dart';

class WeatherService {
  final String apiKey;
  final WeatherFactory weatherFactory;

  WeatherService({required this.apiKey})
      : weatherFactory = WeatherFactory(apiKey);

  Future<List<Weather>> getFiveDayForecastByLocation(double lat, double lon) async {
    return await weatherFactory.fiveDayForecastByLocation(lat, lon);
  }

  Future<List<Weather>> getFiveDayForecastByCityName(String cityName) async {
    return await weatherFactory.fiveDayForecastByCityName(cityName);
  }
}
