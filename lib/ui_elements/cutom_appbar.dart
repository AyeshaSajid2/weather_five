import 'package:flutter/material.dart';
import 'package:weather_five/ui_elements/date_screen.dart';

class CutomAppBar extends StatefulWidget {
  const CutomAppBar({super.key});

  @override
  State<CutomAppBar> createState() => _CutomAppBarState();
}

class _CutomAppBarState extends State<CutomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TodayScreen(),
    );
  }
}
