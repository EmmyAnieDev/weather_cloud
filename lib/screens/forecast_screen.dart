import 'package:flutter/material.dart';
import 'package:weather_cloud/utilities/constants.dart';
import 'package:weather_cloud/utilities/reusable_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({super.key});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  late String cityName;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.9,
      height: 600.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
      ),
      child: Padding(
        padding: REdgeInsets.only(top: 8, bottom: 10, left: 20, right: 20).r,
        child: Column(
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 8.h),
                child: Text(
                  '8 days forecast',
                  style: kTextStyle3,
                ),
              ),
            ),
            const Expanded(
              child: ForecastCard(
                day: 'Yesterday',
                date: '17/12',
                condition: '21°C',
              ),
            ),
            Expanded(
              child: Card(
                color: Colors.white,
                child: Center(
                  child: ListTile(
                    title: Text(
                      'Today',
                      style: kTextStyle5,
                    ),
                    subtitle: Text(
                      '18/12',
                      style: kTextStyle8,
                    ),
                    trailing: Text(
                      '22°C',
                      style: kTextStyle6,
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: ForecastCard(
                day: 'Tuesday',
                date: '19/12',
                condition: '22°C',
              ),
            ),
            const Expanded(
              child: ForecastCard(
                day: 'Wednesday',
                date: '20/12',
                condition: '20°C',
              ),
            ),
            const Expanded(
              child: ForecastCard(
                day: 'Thursday',
                date: '21/12',
                condition: '23°C',
              ),
            ),
            const Expanded(
              child: ForecastCard(
                day: 'Friday',
                date: '22/12',
                condition: '21°C',
              ),
            ),
            const Expanded(
              child: ForecastCard(
                day: 'Saturday',
                date: '23/12',
                condition: '20°C',
              ),
            ),
            const Expanded(
              child: ForecastCard(
                day: 'Sunday',
                date: '24/12',
                condition: '17°C',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
