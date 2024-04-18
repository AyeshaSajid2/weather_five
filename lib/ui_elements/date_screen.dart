import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


// Import the intl package for date formatting

class TodayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get current date
    DateTime now = DateTime.now();
    // Format date to display both day and date
    String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(now);
    return Text(
        formattedDate, // Display formatted date
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ), // Adjust text style
      );
  }
}
