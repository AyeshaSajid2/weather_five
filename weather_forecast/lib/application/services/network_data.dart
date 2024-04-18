import 'dart:convert';

import 'package:http/http.dart' as http;

/// Weather API network helper
/// Pass the weather API URL to this class to get geographical coordinates
class NetworkData {
  NetworkData(this.latitude, this.longitude, this.apiKey);

  final double latitude;
  final double longitude;
  final String apiKey;

  /// Get geographical coordinates from the OpenWeatherMap API call
  Future getData() async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
