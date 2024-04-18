import 'package:flutter/material.dart';
import 'package:weather_forecast/presentation/router/router_generator.dart';

import 'application/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          textTheme: TextTheme(bodyText2: TextStyle(color: white))),
      // home: Dashboard(),
      onGenerateRoute: RouterNavigator.generateRoute,
    );
  }
}
