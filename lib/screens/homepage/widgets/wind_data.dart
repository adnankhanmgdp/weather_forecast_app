import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WindDataView extends StatelessWidget {
  final double windSpeed;
  const WindDataView({super.key, required this.windSpeed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.air, color: Colors.white, size: 35),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            // ignore: unnecessary_string_escapes
            "${windSpeed.toStringAsFixed(1)} m/s",
            style: GoogleFonts.aBeeZee(
                fontWeight: FontWeight.w300, color: Colors.white, fontSize: 25),
          ),
        ),
      ],
    );
  }
}
