class ForecastModel {
  final DateTime datetime;
  final List<ForecastData> data;
  double minTemp;
  double maxTemp;
  ForecastModel({
    required this.datetime,
    required this.data,
    required this.minTemp,
    required this.maxTemp,
  });
}

class ForecastData {
  final String time;
  final double temperature;

  ForecastData(this.time, this.temperature);
}