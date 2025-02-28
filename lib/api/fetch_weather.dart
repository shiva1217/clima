import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clima/model/weather_data.dart';
import 'package:clima/model/weather_data_current.dart';
import 'package:clima/model/weather_data_daily.dart';
import 'package:clima/model/weather_data_hourly.dart';
import 'package:clima/utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  // procecssing the data from response -> to json
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));

    return weatherData!;
  }
}
