import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_forcast_app/utility/app_providers.dart';

class CurrentTemperature extends ConsumerWidget {
  final double celciusTemp, fahrenheitTemp;
  const CurrentTemperature({super.key,  required this.celciusTemp, required this.fahrenheitTemp});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCelsius = ref.watch(isCelsiusProvider);
    dynamic temp = double.parse(((isCelsius)?celciusTemp:fahrenheitTemp).toStringAsFixed(1));
    temp = (temp == temp.toInt())?temp.toInt():temp;
    return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " $temp",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 120),
                ),
                Text(
                  isCelsius ? '°C' : '°F',
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 30),
                )
              ],
            );
  }
}