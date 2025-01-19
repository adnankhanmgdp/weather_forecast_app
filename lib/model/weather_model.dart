class WeatherModel {
  String city, description, detail;
  double tempCelcius, tempFahrenheit, windSpeed;
  int humidity;
  int sunrise, sunset;
  WeatherModel(
      {required this.city,
      required this.tempCelcius,
      required this.tempFahrenheit,
      required this.humidity,
      required this.windSpeed,
      required this.description,
      required this.detail,
      required this.sunrise,
      required this.sunset});

  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        city: json['name'],
        tempCelcius: double.parse("${json['main']['temp']}"),
        tempFahrenheit: celsiusToFahrenheit(double.parse("${json['main']['temp']}")),
        humidity: int.parse("${json['main']['humidity']}"),
        windSpeed: double.parse("${json['wind']['speed']}"),
        description: json['weather'][0]['main'],
        detail: json['weather'][0]['description'],
        sunrise: json['sys']['sunrise'],
        sunset: json['sys']['sunset']);
  }
}
