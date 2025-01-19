import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forcast_app/utility/app_constants.dart';

class ApiService
{
  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse('${AppConstants.weatherApiUrl}/weather?q=$city&units=metric&appid=${AppConstants.weatherApiKey}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      String err = jsonDecode(response.body)['message'];
      Fluttertoast.showToast(
        msg: err,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 53, 53, 53),
        textColor: Colors.white,
        fontSize: 16.0
    );
      throw Exception(err);
    }
  }
  Future<List<dynamic>> fetchForecast(String city) async {
    final url = Uri.parse('${AppConstants.weatherApiUrl}/forecast?q=$city&units=metric&appid=${AppConstants.weatherApiKey}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['list'];
    } else {
      String err = jsonDecode(response.body)['message'];
      Fluttertoast.showToast(
        msg: err,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 53, 53, 53),
        textColor: Colors.white,
        fontSize: 16.0
    );
      throw Exception(err);
    }
  }
}