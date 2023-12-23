import 'package:weather_cloud/services/location.dart';
import 'package:weather_cloud/services/network.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '664835e37e3a1b6d263e26084127b8b8';
const openWeatherMapApi = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future getCityWeather(String cityName) async {
    // using the networkHelper to fetch the searched city weather data from it's lat & lon
    var url = '$openWeatherMapApi?q=$cityName&appid=$apiKey&units=metric';

    Network networkHelper = Network(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    // using the networkHelper to fetch the current location's weather data from it's lat & lon
    Network networkHelper = Network(
        '$openWeatherMapApi?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    //getData is used here to Ensure we don't pass empty values to API for lat and lon
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  // Future getHourlyForecast(double lat, double lon) async {
  //   String apiUrl =
  //       'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=current,minutely,daily&appid=$apiKey&units=metric';
  //
  //   // Perform the API request
  //   http.Response response = await http.get(Uri.parse(apiUrl));
  //   print('API URL: $apiUrl');
  //
  //   if (response.statusCode == 200) {
  //     String data = response.body;
  //     var decodedData = jsonDecode(data);
  //     print('Decoded Data: $decodedData');
  //
  //     if (decodedData != null) {
  //       var hourlyForecast = decodedData['hourly'];
  //       print('Hourly Forecast Data: $hourlyForecast');
  //
  //       return hourlyForecast;
  //     } else {
  //       print('No Hourly Forecast Data available');
  //       return null;
  //     }
  //   } else {
  //     print('Failed to fetch data. Status Code: ${response.statusCode}');
  //     return null;
  //   }
  // }

  // Future<Map<String, dynamic>> getEightDayForecast(double lat, double lon) async {
  //   final apiUrl =
  //       'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=current,minutely,daily&appid=$apiKey&units=metric';
  //
  //   final response = await http.get(Uri.parse(apiUrl));
  //
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = json.decode(response.body);
  //     return data;
  //   } else {
  //     throw Exception('Failed to load 8-day forecast');
  //   }
  // }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '❄';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☁️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
