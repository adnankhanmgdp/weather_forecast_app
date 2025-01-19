import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forcast_app/screens/city_search/view/city_search.dart';
import 'package:weather_forcast_app/screens/homepage/widgets/forecast_data.dart';
import 'package:weather_forcast_app/screens/homepage/widgets/wind_data.dart';
import 'package:weather_forcast_app/utility/app_constants.dart';
import 'package:weather_forcast_app/utility/app_providers.dart';
import 'package:weather_forcast_app/screens/homepage/widgets/humidity_data.dart';
import 'package:weather_forcast_app/screens/homepage/widgets/weather_data.dart';
import 'package:intl/intl.dart';
import 'package:weather_forcast_app/utility/local_storage.dart';
import '../widgets/temperature.dart';

class WeatherHomePage extends ConsumerWidget {
  const WeatherHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDay = true;
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH').format(now);
    if (int.parse(formattedTime) > 18 || int.parse(formattedTime) < 6) {
      isDay = false;
    } else {
      isDay = true;
    }
    bool isCelsius = ref.watch(isCelsiusProvider);
    () async {
      ref.read(isCelsiusProvider.notifier).state =
          await WeatherPreferences.getUnit() ?? true;
    };
    final weather = ref.watch(weatherProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              (weather.detail == 'clear sky')
                  ? (isDay)
                      ? AppConstants.clearDayImage
                      : AppConstants.clearNightImage
                  : (weather.detail.endsWith('clouds'))
                      ? AppConstants.cloudyImage
                      : (weather.detail.endsWith('rain'))
                          ? AppConstants.rainyImage
                          : (weather.detail == 'snow')
                              ? AppConstants.snowyImage
                              : (weather.detail == 'mist' ||
                                      weather.detail == 'haze' ||
                                      weather.detail.contains('fog'))
                                  ? AppConstants.hazeImage
                                  : AppConstants.cloudyImage,
              // AppConstants.rainyImage
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 35,
                      weight: 1,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchCity()));
                    },
                  ),
                  Text(
                    weather.city.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Temperature unit toggle will go here
                  IconButton(
                    icon: Text(
                      isCelsius ? '°F' : '°C',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w300),
                    ),
                    onPressed: () async {
                      ref.read(isCelsiusProvider.notifier).state = !isCelsius;
                      await WeatherPreferences.saveUnit(!isCelsius);
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Today",
                style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              CurrentTemperature(
                  celciusTemp: weather.tempCelcius,
                  fahrenheitTemp: weather.tempFahrenheit),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WeatherDataView(weather: weather.description),
                  const SizedBox(
                    width: 10,
                  ),
                  HumidityDataView(humidity: weather.humidity),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              WindDataView(windSpeed: weather.windSpeed),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.sunny, color: Colors.white, size: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          DateFormat('hh:mm a').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  weather.sunrise * 1000)),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.nights_stay,
                          color: Colors.white, size: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          DateFormat('hh:mm a').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  weather.sunset * 1000)),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const ForecastBox(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
