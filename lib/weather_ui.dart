import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherUI extends StatelessWidget {
  final List<Weather> forecast;

  const WeatherUI({Key? key, required this.forecast}) : super(key: key);

  String getWeatherIcon(String weatherDescription) {
    switch (weatherDescription.toLowerCase()) {
      case 'clouds':
        return '☁️';
      case 'clear':
        return '☀️';
      case 'rain':
        return '🌧';
      case 'snow':
        return '❄️';
      case 'thunderstorm':
        return '⛈';
      default:
        return '🤷‍♂️';
    }
  }

  double _calculateAverageTemperature(List<Weather> forecast) {
    double totalTemperature = forecast.fold(0, (prev, weather) => prev + weather.temperature!.celsius!);
    return totalTemperature / forecast.length;
  }

  String _getOverallMessage(double averageTemperature) {
    if (averageTemperature > 25) {
      return 'It\'s 🍦 time';
    } else if (averageTemperature > 20) {
      return 'Time for shorts and 👕';
    } else if (averageTemperature < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Widget _buildAverageTemperature(double averageTemperature) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            'Average Temperature: ${averageTemperature.toStringAsFixed(1)}°C ',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureList(Weather weather, double averageTemperature) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFBAC2FF),
        border: Border.all(color: Colors.black),
      ),
      child: ListTile(
        title: Text(
          'Time: ${weather.date}',
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          '${weather.temperature!.celsius!.toStringAsFixed(1)}°C ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: Text(
          getWeatherIcon(weather.weatherMain!),
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double averageTemperature = _calculateAverageTemperature(forecast);
    String overallMessage = _getOverallMessage(averageTemperature);

    return Scaffold(
      backgroundColor: Color(0xFF9AC8CD),
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Date: ${forecast.first.date}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          _buildAverageTemperature(averageTemperature),
          Expanded(
            child: ListView.builder(
              itemCount: forecast.length,
              itemBuilder: (context, index) {
                Weather weather = forecast[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildTemperatureList(weather, averageTemperature),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              overallMessage,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
