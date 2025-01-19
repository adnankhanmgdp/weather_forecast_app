import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherDataView extends StatelessWidget {
  final String weather;
  const WeatherDataView({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Text(
      weather,
      style: GoogleFonts.aBeeZee(
          fontWeight: FontWeight.w800, color: const Color.fromARGB(255, 255, 255, 255), fontSize: 20, letterSpacing: 1.5),
    );
  }
}
