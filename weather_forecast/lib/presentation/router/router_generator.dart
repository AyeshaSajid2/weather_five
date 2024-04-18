import 'package:flutter/material.dart';

import '../pages/weather_app.dart';

class RouterNavigator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Weather());

      default:
        return MaterialPageRoute(builder: (context) => Weather());
    }
  }
}
