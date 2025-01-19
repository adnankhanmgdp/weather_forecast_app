import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_forcast_app/utility/app_providers.dart';
import '../../../model/forecast_model.dart';

class ForecastBox extends StatelessWidget {
   const ForecastBox({super.key});
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            width: width * 0.95,
            // height: 300.0,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.calendar_month_sharp,
                              color: Colors.grey[700], size: 20)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          "3-day forcast",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    // height: 190,
                    child: Consumer(
                      builder: (context, ref, child)
                      {
                        final forecasts = ref.watch(forecastProvider);
                        return Scrollbar(
                        thumbVisibility: true,
                        controller: scrollController,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: scrollController,
                            child:  Column(
                              children: [
                                for(int i = 0; i < forecasts.length; i++)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(getDayFromDate(forecasts[i].datetime),
                                        style: GoogleFonts.aBeeZee(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                     WeatherChart(forecast: forecasts[i],),
                                  ],
                                )
                              ],
                            )
                            ),
                      );
                      }
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class WeatherChart extends StatelessWidget {
  final ForecastModel forecast;
  const WeatherChart({super.key, required this.forecast});
  @override
  Widget build(BuildContext context) {
    final List<ForecastData> forecastData = forecast.data;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 100,
      width: width * 1.5,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        onTooltipRender: (tooltipArgs) {
          tooltipArgs.header = getDayFromDate(forecast.datetime).substring(0,3);
        },
        primaryXAxis: const CategoryAxis(
            isVisible: false, title: AxisTitle(text: 'Time')),
        primaryYAxis:  NumericAxis(
          isVisible: false,
          title: const AxisTitle(text: 'Temperature (°C)'),
          minimum: forecast.minTemp - 5, // Minimum temperature value
          maximum: forecast.maxTemp + 5, // Maximum temperature value
          interval: 1, // Interval between labels
        ),
        
        series: <CartesianSeries>[
          LineSeries<ForecastData, String>(
            
            dataSource: forecastData,
            xValueMapper: (ForecastData data, _) => data.time,
            yValueMapper: (ForecastData data, _) => data.temperature,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              builder: (data, point, series, pointIndex, seriesIndex) => Text(
                '${data.time}\n${data.temperature.toStringAsFixed(1)}°C',
                style: GoogleFonts.aBeeZee(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            color: Colors.white,
            width: 3,
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true,
        format: 'point.x\npoint.y °C'
        ),
      ),
    );
  }
}

String getDayFromDate(DateTime date) {
  const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  return days[date.weekday - 1]; // Subtract 1 because weekday is 1-based
}