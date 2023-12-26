// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:weather_cloud/utilities/constants.dart';
import 'package:weather_cloud/screens/search_screen.dart';
import 'package:weather_cloud/screens/forecast_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_cloud/utilities/reusable_widget.dart';
import 'package:weather_cloud/services/weather.dart';
import 'package:weather_cloud/services/location.dart';

class LocationScreen extends StatefulWidget {
  final dynamic locationWeather;

  const LocationScreen({super.key, this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  // List<Map<String, dynamic>> hourlyData = []; // Define hourlyData list

  int? temperature;
  String? temperatureMessage;
  String? weatherIcon;
  String? cityName;
  String? description;
  int? tempMax;
  int? tempMin;
  int? humidityForecast;
  int? windForecast;
  int? precipitation;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);

    if (widget.locationWeather != null) {
      Location location = Location();
      location.getCurrentLocation().then((_) {
        //   updateHourlyForecast(location.latitude, location.longitude);
      });
    }
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        temperatureMessage = 'Unable to get weather data';
        cityName = 'Error';
        return;
      }

      if (weatherData.containsKey('main') &&
          weatherData['main'] != null &&
          weatherData.containsKey('weather') &&
          weatherData['weather'] != null &&
          weatherData['weather'].isNotEmpty &&
          weatherData['weather'][0].containsKey('id') &&
          weatherData.containsKey('name') &&
          weatherData.containsKey('wind') &&
          weatherData['wind'] != null &&
          weatherData['wind'].containsKey('speed')) {
        double temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        var condition = weatherData['weather'][0]['id'];
        cityName = weatherData['name'];
        description = weatherData['weather'][0]['description'];
        double highTemp = weatherData['main']['temp_max'];
        tempMax = highTemp.toInt();
        double lowTemp = weatherData['main']['temp_min'];
        tempMin = lowTemp.toInt();
        humidityForecast = weatherData['main']['humidity'];
        double speed = weatherData['wind']['speed'];
        windForecast = speed.toInt();

        if (weatherData.containsKey('rain') &&
            weatherData['rain'] != null &&
            weatherData['rain'].containsKey('1h') &&
            weatherData['rain']['1h'] != null) {
          double rainValue = weatherData['rain']['1h'];
          precipitation = rainValue.toInt();
        } else {
          precipitation = 0; // Set a default value if '1h' key is null
        }

        weatherIcon = weather.getWeatherIcon(condition);
        //print('Weather Icon: $weatherIcon'); // Add this line for debugging
      } else {
        temperature = 0;
        weatherIcon = 'Error';
        temperatureMessage = 'Weather data is incomplete';
        cityName = 'Error';
      }
    });
  }

  final List<Map<String, dynamic>> hourlyData = [
    {'time': '01', 'temperature': 25, 'icon': Icons.ac_unit},
    {'time': '02', 'temperature': 23, 'icon': Icons.wb_cloudy},
    {'time': '03', 'temperature': 21, 'icon': Icons.wb_cloudy},
    {'time': '04', 'temperature': 20, 'icon': Icons.wb_cloudy},
    {'time': '05', 'temperature': 21, 'icon': Icons.wb_cloudy},
    {'time': '06', 'temperature': 20, 'icon': Icons.wb_cloudy},
    {'time': '07', 'temperature': 21, 'icon': Icons.wb_cloudy},
    {'time': '08', 'temperature': 20, 'icon': Icons.wb_cloudy},
    {'time': '03', 'temperature': 21, 'icon': Icons.wb_cloudy},
    {'time': '04', 'temperature': 20, 'icon': Icons.wb_cloudy},
    {'time': '05', 'temperature': 21, 'icon': Icons.wb_cloudy},
    {'time': '06', 'temperature': 20, 'icon': Icons.wb_cloudy},
    {'time': '07', 'temperature': 21, 'icon': Icons.wb_cloudy},
    {'time': '08', 'temperature': 20, 'icon': Icons.wb_cloudy},
  ];

  // Future<void> updateHourlyForecast(double? lat, double? lon) async {
  //   if (lat != null && lon != null) {
  //     var hourlyForecastData = await weather.getHourlyForecast(lat, lon);
  //     print('Hourly Forecast Data: $hourlyForecastData');
  //
  //     if (hourlyForecastData != null && hourlyForecastData is List) {
  //       setState(() {
  //         hourlyData = hourlyForecastData
  //             .map((hourData) => {
  //                   'time': hourData[
  //                       'dt'], // Assuming 'dt' holds the time information
  //                   'temperature': hourData['temp'].toInt(),
  //                   'icon':
  //                       weather.getWeatherIcon(hourData['weather'][0]['id']),
  //                 })
  //             .toList();
  //         print('Updated Hourly Data: $hourlyData');
  //       });
  //     } else {
  //       print('Hourly Forecast Data is not a List or is null');
  //     }
  //   } else {
  //     print('Latitude or Longitude is null');
  //   }
  // }

  @override
  void didUpdateWidget(covariant LocationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.locationWeather != null) {
      updateUI(widget.locationWeather);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20).r,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${cityName is String ? cityName : 'Invalid City Name'}',
                      style: kTextStyle10),
                  Text(
                    weatherIcon ??
                        'Unknown', // Use 'Unknown' if weatherIcon is null
                    style: TextStyle(fontSize: 125.sp),
                  ),
                  Text(
                    '$temperature°C',
                    style: TextStyle(
                      color: Colors.white60,
                      fontWeight: FontWeight.bold,
                      fontSize: 90.sp,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.h, horizontal: 15.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white24),
                        child: Text('$description', style: kTextStyle1),
                      ),
                      SizedBox(width: 10.w),
                      Text('H:$tempMax° L:$tempMin°', style: kTextStyle1)
                    ],
                  ),
                  SizedBox(height: 10.h),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ConditionContent(
                          icon: Icons.thermostat,
                          condition: '$humidityForecast %',
                          pressure: 'Humidity',
                        ),
                        const VerticalDivider(
                          width: 1,
                          color: Colors.white30,
                          thickness: 3,
                          indent: 15,
                          endIndent: 15,
                        ),
                        ConditionContent(
                          icon: Icons.wind_power,
                          condition: '$windForecast km/h',
                          pressure: 'Wind',
                        ),
                        const VerticalDivider(
                          width: 1,
                          color: Colors.white30,
                          thickness: 3,
                          indent: 15,
                          endIndent: 15,
                        ),
                        ConditionContent(
                          icon: Icons.cloudy_snowing,
                          condition: '$precipitation %',
                          pressure: 'Precipitation',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 100.sp,
                    padding: REdgeInsets.only(left: 10, top: 10, bottom: 10).r,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.black38),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hourlyData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${hourlyData[index]['time']}',
                                style: kTextStyle9,
                              ),
                              const SizedBox(height: 8.0),
                              Icon(
                                hourlyData[index]['icon'],
                                size: 20.sp,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                '${hourlyData[index]['temperature']}°C',
                                style: kTextStyle1,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);
                        },
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '8 days weather forecast',
                            style: kTextStyle1,
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => const WeatherForecast(),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () async {
                          var selectedCityWeather = await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => const SearchCity(),
                          );

                          if (selectedCityWeather != null) {
                            updateUI(selectedCityWeather);
                          }
                        },
                        icon: const Icon(
                          Icons.location_city,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
