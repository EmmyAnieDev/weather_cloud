// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:weather_cloud/utilities/reusable_widget.dart';
import 'package:weather_cloud/utilities/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_cloud/screens/add_location_screen.dart';
import 'package:weather_cloud/services/weather.dart';
import 'package:weather_cloud/services/local_time.dart';

class SearchCity extends StatefulWidget {
  final String? cityName;
  const SearchCity({super.key, this.cityName});

  @override
  State<SearchCity> createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  final FocusNode _focusNode = FocusNode();
  Map<String, double> cityTemperatures = {}; // Map to hold city temperatures
  Map<String, String> cityTimes = {};
  Map<String, String> cityDescriptions = {};
  Map<String, double> cityTempMax = {};
  Map<String, double> cityTempMin = {};
  String? cityName;
  WeatherModel weatherModel = WeatherModel();

  Future<void> _showAddLocationScreen(BuildContext context) async {
    final result = await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const AddLocation(),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        cityTemperatures[result] =
            0.0; // Add city to the map with default temperature
      });
      await _updateWeatherAndTimeForCity(
          result); // Fetch weather for the added city
    }
  }

  Future<void> _updateWeatherAndTimeForCity(String cityName) async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getCityWeather(cityName);

    if (weatherData != null) {
      double? temperature = weatherData['main']['temp'];
      String? description = weatherData['weather'][0]['description'];
      double? tempMax = weatherData['main']['temp_max'];
      double? tempMin = weatherData['main']['temp_min'];
      setState(() {
        cityTemperatures[cityName] = temperature ?? 0.0;
        cityDescriptions[cityName] = description ?? '';
        cityTempMax[cityName] = tempMax ?? 0.0;
        cityTempMin[cityName] = tempMin ?? 0.0;
      });
    }

// using the latitude and longitude of the city to get its local time
    double? latitude = weatherData['coord']['lat'];
    double? longitude = weatherData['coord']['lon'];

    if (latitude != null && longitude != null) {
      String cityTime = await _getLocalTimeForCity(latitude, longitude);
      setState(() {
        cityTimes[cityName] = cityTime;
      });
    }
  }

  Future<String> _getLocalTimeForCity(double lat, double lon) async {
    try {
      TimezoneService timezoneService = TimezoneService();
      String cityTime = await timezoneService.getLocalTime(lat, lon);
      return cityTime;
    } catch (e) {
//print('Error fetching local time: $e');
      return ''; // Return an empty string in case of error
    }
  }

  void removeCity(String cityName) {
    setState(() {
      cityTemperatures.remove(cityName);
      cityTimes.remove(cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
        }
      },
      child: Container(
        height: 600.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: ListView(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    'Manage Cities',
                    style: kTextStyle3,
                  ),
                ),
              ),
              Container(
                padding:
                    REdgeInsets.symmetric(vertical: 15.0.h, horizontal: 2.0.w),
                child: TextField(
                    focusNode: _focusNode,
                    onSubmitted: (value) async {
                      var weatherData =
                          await weatherModel.getCityWeather(value);
                      Navigator.pop(context, weatherData);
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: kTextFieldSearchDecoration),
              ),
              Column(
                children: cityTemperatures.entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: LocationCard(
                      addedLocationName: entry.key,
                      addedLocationTime: cityTimes[entry.key] ?? '',
                      addedLocationTemp: '${entry.value.toInt()}°C',
                      addedLocationDescription:
                          cityDescriptions[entry.key] ?? '',
                      addedLocationHighLowTemp:
                          'H:${cityTempMax[entry.key]?.toInt() ?? 0}° L:${cityTempMin[entry.key]?.toInt() ?? 0}°',
                      onDelete: () {
                        removeCity(entry.key);
                      },
                      onTap: () async {
                        var cityName =
                            entry.key; // Assuming entry.key is the city name
                        var weatherData =
                            await weatherModel.getCityWeather(cityName);
                        Navigator.pop(context, weatherData);
                      },
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 30.w,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: Colors.white24,
                  ),
                  child: TextButton(
                    onPressed: () {
                      _showAddLocationScreen(context);
                    },
                    child: Text(
                      'Add location',
                      style: kTextStyle4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
