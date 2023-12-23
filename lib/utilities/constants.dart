import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kBackgroundColor = Color(0xFF3366ff);

final kTextStyle1 = TextStyle(
  color: Colors.white,
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
);

final kTextStyle2 = TextStyle(
  color: Colors.white,
  fontSize: 11.sp,
  fontWeight: FontWeight.w500,
);

final kTextStyle3 = TextStyle(
  color: Colors.white,
  fontSize: ScreenUtil().setSp(16),
  fontWeight: FontWeight.w500,
);

final kTextStyle4 = TextStyle(
  color: Colors.white,
  fontSize: ScreenUtil().setSp(20),
  fontWeight: FontWeight.w500,
);

final kTextStyle5 = TextStyle(
  color: Colors.blueAccent,
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
);

final kTextStyle6 = TextStyle(
  color: Colors.blueAccent,
  fontSize: 20.sp,
  fontWeight: FontWeight.w500,
);

final kTextStyle7 = TextStyle(
  color: Colors.white,
  fontSize: 13.sp,
  fontWeight: FontWeight.w500,
);

final kTextStyle8 = TextStyle(
  color: Colors.lightBlueAccent,
  fontSize: 14.sp,
  fontWeight: FontWeight.w500,
);

final kTextStyle9 = TextStyle(
  color: Colors.white,
  fontSize: 11.sp,
  fontWeight: FontWeight.w500,
);

final kTextStyle10 = TextStyle(
  color: Colors.white,
  fontSize: 30.sp,
  fontWeight: FontWeight.bold,
);

final kTextFieldSearchDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.search,
    size: 25.sp,
    color: Colors.grey,
  ),
  hintText: 'Search for city or airport',
  hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50.r),
    ),
    borderSide: BorderSide.none,
  ),
  isDense: true,
  contentPadding: EdgeInsets.all(9.r),
);

final kTextFieldLocationDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.location_city,
    size: 25.sp,
    color: Colors.grey,
  ),
  hintText: 'type a location to add',
  hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50.r),
    ),
    borderSide: BorderSide.none,
  ),
  isDense: true,
  contentPadding: EdgeInsets.all(9.r),
);
