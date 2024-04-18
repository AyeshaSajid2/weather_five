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

class WeatherModel {
  Future<List<dynamic>> getFiveDayForecast(double latitude, double longitude) async {
    var url = '$weatherApiUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    NetworkData networkHelper = NetworkData(url);
    var weatherData = await networkHelper.getData();
    List<dynamic> forecastList = weatherData['list'];
    return forecastList;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    /// Get location data
    NetworkData networkHelper = NetworkData(
        '$weatherApiUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  getCityWeather(String cityName) {
    var url = '$weatherApiUrl?q=$cityName&appid=$apiKey&units=metric';
    NetworkData networkHelper = NetworkData(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }
}





// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';
//
// const weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather';
// const apiKey = '2e9714911e1deb0a2ee62104c0b5928b';
//
// // http://history.openweathermap.org/data/2.5/history/
// // city?id=2885679&type=hour&appid=bc13ab0d599e7dea64925e415980a41b
//
// class Location {
//   double? latitude;
//   double? longitude;
//
//   Future<void> getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//
//       latitude = position.latitude;
//       longitude = position.longitude;
//     } catch (e) {
//       print('Error getting location: $e');
//       // Providing default location (New York City coordinates)
//       latitude = 40.7128;
//       longitude = -74.0060;
//     }
//   }
// }
//
// class NetworkData {
//   NetworkData(this.url);
//   final String url;
//
//   Future getData() async {
//     http.Response response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       String data = response.body;
//       return jsonDecode(data);
//     } else {
//       print(response.statusCode);
//       throw Exception('Failed to load data');
//     }
//   }
// }
//
// class WeatherModel {
//   Future<dynamic> getCityWeather(String cityName) async {
//     var url = '$weatherApiUrl?q=$cityName&appid=$apiKey&units=metric';
//     NetworkData networkHelper = NetworkData(url);
//     var weatherData = await networkHelper.getData();
//     return weatherData;
//   }
//
//   Future<dynamic> getLocationWeather() async {
//     Location location = Location();
//     await location.getCurrentLocation();
//
//     var url =
//         '$weatherApiUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
//     NetworkData networkHelper = NetworkData(url);
//     var weatherData = await networkHelper.getData();
//     return weatherData;
//   }
//
//   String getWeatherIcon(int condition) {
//     if (condition < 300) {
//       return '🌩';
//     } else if (condition < 400) {
//       return '🌧';
//     } else if (condition < 600) {
//       return '☔️';
//     } else if (condition < 700) {
//       return '☃️';
//     } else if (condition < 800) {
//       return '🌫';
//     } else if (condition == 800) {
//       return '☀️';
//     } else if (condition <= 804) {
//       return '☁️';
//     } else {
//       return '🤷‍';
//     }
//   }
//
//   String getMessage(int temp) {
//     if (temp > 25) {
//       return 'It\'s 🍦 time';
//     } else if (temp > 20) {
//       return 'Time for shorts and 👕';
//     } else if (temp < 10) {
//       return 'You\'ll need 🧣 and 🧤';
//     } else {
//       return 'Bring a 🧥 just in case';
//     }
//   }
// }
