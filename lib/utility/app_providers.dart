import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forcast_app/model/forecast_model.dart';
import 'package:weather_forcast_app/model/weather_model.dart';
// Providers
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final isCelsiusProvider = StateProvider<bool>((ref) => true);
final cityNameProvider = StateProvider<String>((ref) => "Lucknow");


class WeatherNotifier extends StateNotifier<WeatherModel> {
  WeatherNotifier() : super(WeatherModel(
    city: '',
    tempCelcius: 0,
    tempFahrenheit: 0,
    humidity: 0,
    windSpeed: 0,
    description: '',
    detail: '',
    sunrise: 0,
    sunset: 0
  ));
  void updateWeather(WeatherModel weather) {
    state = weather;
  }
}
final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherModel>((ref) => WeatherNotifier());

// Notifier for 3-days Forecasts list
class ForecastNotifier extends StateNotifier<List<ForecastModel>> {
  ForecastNotifier() : super([]);
  void updateForecast(List<ForecastModel> forecasts) {
    state = forecasts;
  }
}
final forecastProvider = StateNotifierProvider<ForecastNotifier, List<ForecastModel>>((ref) => ForecastNotifier());