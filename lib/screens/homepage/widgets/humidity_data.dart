import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HumidityDataView extends StatelessWidget {
  final int humidity;
  const HumidityDataView({super.key, required this.humidity});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.water_drop, color: Colors.white, size: 35),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "$humidity%",
            style: GoogleFonts.aBeeZee(
                fontWeight: FontWeight.w300, color: Colors.white, fontSize: 25),
          ),
        ),
      ],
    );
  }
}
