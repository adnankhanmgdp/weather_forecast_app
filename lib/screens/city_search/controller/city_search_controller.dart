import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_forcast_app/model/weather_model.dart';
import 'package:weather_forcast_app/screens/homepage/view/homescreen.dart';
import 'package:weather_forcast_app/utility/api_service.dart';
import 'package:weather_forcast_app/utility/app_providers.dart';
import 'package:intl/intl.dart';
import 'package:weather_forcast_app/utility/local_storage.dart';

import '../../../model/forecast_model.dart';

class CitySearchController {
  static void onCitySelected(
      WidgetRef ref, String city, BuildContext context) async {
    if (city.length >= 3) {
      try {
        Map<String, dynamic> resp = await ApiService().fetchWeather(city);
        if (resp['cod'] == 200) {
          ref.read(cityNameProvider.notifier).state = city;
          WeatherModel weather = WeatherModel.fromJson(resp);
          ref.read(weatherProvider.notifier).updateWeather(weather);
          List<dynamic> forecastResp = await ApiService().fetchForecast(city);
          DateTime now = DateTime.now();
          List<ForecastModel> forecasts = [];
          for (int k = 1; k <= 3; k++) {
            forecasts.add(ForecastModel(
                datetime: DateTime.now().add(Duration(days: k)),
                data: [],
                minTemp: 0,
                maxTemp: 0));
            String day =
                DateFormat('dd-MM-yy').format(now.add(Duration(days: k)));
            for (int i = 0; i < forecastResp.length; i++) {
              int dt = forecastResp[i]['dt'];
              String formattedDt = DateFormat('dd-MM-yy')
                  .format(DateTime.fromMillisecondsSinceEpoch(dt * 1000));
              if (formattedDt == day) {
                String time = DateFormat('hh:mm a')
                    .format(DateTime.fromMillisecondsSinceEpoch(dt * 1000));
                forecasts[k - 1].data.add(ForecastData(
                    time, double.parse("${forecastResp[i]['main']['temp']}")));
                if (forecasts[k - 1].minTemp >
                    forecastResp[i]['main']['temp']) {
                  forecasts[k - 1].minTemp =
                      double.parse("${forecastResp[i]['main']['temp']}");
                }
                if (forecasts[k - 1].maxTemp <
                    forecastResp[i]['main']['temp']) {
                  forecasts[k - 1].maxTemp =
                      double.parse("${forecastResp[i]['main']['temp']}");
                }
              }
            }
          }
          ref.read(forecastProvider.notifier).updateForecast(forecasts);
          await WeatherPreferences.saveCity(city);
          await WeatherPreferences.saveTemp(weather.tempCelcius.toString());
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => WeatherHomePage()),
            (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
        msg: "Some error occurred! Try again later.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 53, 53, 53),
        textColor: Colors.white,
        fontSize: 16.0
    );
      }
    }
  }
}
