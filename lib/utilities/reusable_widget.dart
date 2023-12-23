import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConditionContent extends StatelessWidget {
  const ConditionContent(
      {super.key,
      required this.condition,
      required this.icon,
      required this.pressure});

  final IconData icon;
  final String pressure;
  final String condition;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white54,
          size: 35,
        ),
        Text(
          condition,
          style: kTextStyle1,
        ),
        Text(
          pressure,
          style: kTextStyle2,
        ),
      ],
    );
  }
}

class ForecastCard extends StatelessWidget {
  const ForecastCard(
      {super.key,
      required this.condition,
      required this.date,
      required this.day});

  final String day;
  final String date;
  final String condition;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white60,
      child: Center(
        child: ListTile(
          title: Text(
            day,
            style: kTextStyle3,
          ),
          subtitle: Text(
            date,
            style: kTextStyle7,
          ),
          trailing: Text(
            condition,
            style: kTextStyle4,
          ),
        ),
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  const LocationCard(
      {super.key,
      required this.addedLocationTemp,
      required this.addedLocationTime,
      required this.addedLocationName,
      required this.addedLocationDescription,
      required this.addedLocationHighLowTemp,
      required this.onDelete,
      required this.onTap});

  final String addedLocationTemp;
  final String addedLocationTime;
  final String addedLocationName;
  final String addedLocationDescription;
  final String addedLocationHighLowTemp;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(addedLocationName),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0.r),
          color: Colors.red,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(20.0.r),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        onDelete(); // Call the onDelete callback
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white24,
          ),
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(addedLocationName, style: kTextStyle4),
                        Text(addedLocationTime, style: kTextStyle7),
                      ],
                    ),
                    Text(addedLocationTemp, style: kTextStyle10)
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(addedLocationDescription, style: kTextStyle7),
                    Text(addedLocationHighLowTemp, style: kTextStyle7),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
