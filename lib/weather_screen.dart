import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'weather_services.dart';
import 'weather_ui.dart'; // Import the WeatherUI widget

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService(apiKey: 'a377581026c124fafded5d390a5d9732');
  late List<Weather> _forecast = [];
  late String _placeName = '';
  TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeatherForecast(String cityName) async {
    try {
      List<Weather> forecast = await _weatherService.getFiveDayForecastByCityName(cityName);
      setState(() {
        _forecast = forecast;
        _placeName = cityName;
      });
    } catch (e) {
      print('Error fetching weather forecast: $e');
      _showErrorDialog('Error fetching weather forecast', e.toString());
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9AC8CD),
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _fetchWeatherForecast(_cityController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: _forecast.isNotEmpty
                ? WeatherUI(forecast: _forecast)
                : Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:weather/weather.dart';
// import 'package:weather_five/ui_elements/cutom_appbar.dart';
// import 'weather_services.dart';
// import 'weather_ui.dart'; // Import the updated WeatherUI widget
//
// class WeatherScreen extends StatefulWidget {
//   @override
//   _WeatherScreenState createState() => _WeatherScreenState();
// }
//
// class _WeatherScreenState extends State<WeatherScreen> {
//   final WeatherService _weatherService = WeatherService(apiKey: 'a377581026c124fafded5d390a5d9732');
//   late List<List<Weather>> _forecastByDay = [];
//   late int _currentPageIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchWeatherForecast();
//   }
//
//   Future<void> _fetchWeatherForecast() async {
//     double lat = 40.7128; // Latitude of New York City
//     double lon = -74.0060; // Longitude of New York City
//     try {
//       List<Weather> forecast = await _weatherService.getFiveDayForecastByLocation(lat, lon);
//       _forecastByDay = _groupForecastByDay(forecast);
//       setState(() {});
//     } catch (e) {
//       print('Error fetching weather forecast: $e');
//       _showErrorDialog('Error fetching weather forecast', e.toString());
//     }
//   }
//
//   List<List<Weather>> _groupForecastByDay(List<Weather> forecast) {
//     Map<String, List<Weather>> groupedForecast = {};
//     for (var weather in forecast) {
//       String date = weather.date.toString().split(' ')[0]; // Extract date without time
//       if (!groupedForecast.containsKey(date)) {
//         groupedForecast[date] = [];
//       }
//       groupedForecast[date]?.add(weather);
//     }
//     return groupedForecast.values.toList();
//   }
//
//   void _showErrorDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _navigateToNextPage() {
//     if (_currentPageIndex < _forecastByDay.length - 1) {
//       setState(() {
//         _currentPageIndex++;
//       });
//     }
//   }
//
//   void _navigateToPreviousPage() {
//     if (_currentPageIndex > 0) {
//       setState(() {
//         _currentPageIndex--;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _forecastByDay.isNotEmpty
//           ? WeatherUI(forecast: _forecastByDay[_currentPageIndex])
//           : Center(
//         child: CircularProgressIndicator(),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           if (_currentPageIndex > 0)
//             FloatingActionButton(
//               onPressed: _navigateToPreviousPage,
//               child: Icon(Icons.arrow_back),
//             ),
//           if (_currentPageIndex < _forecastByDay.length - 1)
//             FloatingActionButton(
//               onPressed: _navigateToNextPage,
//               child: Icon(Icons.arrow_forward),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:weather/weather.dart';
// // import 'weather_services.dart';
// // import 'weather_ui.dart'; // Import the WeatherUI widget
// //
// // class WeatherScreen extends StatefulWidget {
// //   @override
// //   _WeatherScreenState createState() => _WeatherScreenState();
// // }
// //
// // class _WeatherScreenState extends State<WeatherScreen> {
// //   final WeatherService _weatherService = WeatherService(apiKey: 'a377581026c124fafded5d390a5d9732');
// //   late List<Weather> _forecast = [];
// //   late String _placeName = '';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchWeatherForecast();
// //   }
// //
// //   Future<void> _fetchWeatherForecast() async {
// //     double lat = 40.7128; // Latitude of New York City
// //     double lon = -74.0060; // Longitude of New York City
// //     try {
// //       _forecast = await _weatherService.getFiveDayForecastByLocation(lat, lon);
// //       _placeName = 'New York'; // Set the place name
// //       setState(() {});
// //     } catch (e) {
// //       print('Error fetching weather forecast: $e');
// //       _showErrorDialog('Error fetching weather forecast', e.toString());
// //     }
// //   }
// //
// //   void _showErrorDialog(String title, String message) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text(title),
// //           content: Text(message),
// //           actions: <Widget>[
// //             TextButton(
// //               child: Text('OK'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('5-Day Weather Forecast'),
// //       ),
// //       body: _forecast.isNotEmpty
// //           ? WeatherUI(forecast: _forecast, placeName: _placeName,) // Use the WeatherUI widget
// //           : Center(
// //         child: CircularProgressIndicator(),
// //       ),
// //     );
// //   }
// // }
//
