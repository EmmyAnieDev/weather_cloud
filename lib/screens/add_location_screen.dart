import 'package:flutter/material.dart';
import 'package:weather_cloud/utilities/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final FocusNode _focusNode = FocusNode();
  List<String> cities = [];
  String? locationName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          if (_focusNode.hasFocus) {
            _focusNode.unfocus();
          }
        },
        child: Container(
          height: 400.h,
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
                      'Manage your locations',
                      style: kTextStyle3,
                    ),
                  ),
                ),
                Container(
                  padding: REdgeInsets.symmetric(
                      vertical: 15.0.h, horizontal: 2.0.w),
                  child: TextField(
                      focusNode: _focusNode,
                      onSubmitted: (value) {
                        locationName = value;
                        Navigator.pop(context, locationName);
                        if (locationName != null && locationName!.isNotEmpty) {
                          setState(() {
                            cities.add(locationName!); // Add city to the list
                            locationName = ''; // Clear cityName after adding
                          });
                        }
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: kTextFieldLocationDecoration),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
