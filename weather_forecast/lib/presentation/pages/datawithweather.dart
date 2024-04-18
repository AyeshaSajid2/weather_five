import 'package:flutter/material.dart';
import 'package:weather_forecast/presentation/pages/weather_app.dart';
// import 'package:weather_forecast/application/services/weather_model.dart';
// import 'package:weather_forecast/application/services/weather_model.dart';

class DateWeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5-Day Weather Forecast'),
      ),
      body: FutureBuilder<List<Weather>>(
        future: getFiveDayForecast(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Weather weather = snapshot.data![index];
                return ListTile(
                  title: Text(
                      'Date: ${weather.date.toString().substring(0, 10)}'),
                  subtitle: Text(
                      'Temperature: ${weather.temperature.celsius}°C'),
                );
              },
            );
          } else {
            return Center(
              child: Text('No data available.'),
            );
          }
        },
      ),
    );
  }

  Future<List<Weather>> getFiveDayForecast() async {
    Location location = Location();
    await location.getCurrentLocation();
    return WeatherModel().getFiveDayForecast(
        location.latitude ?? 0.0, location.longitude ?? 0.0);
  }
}
