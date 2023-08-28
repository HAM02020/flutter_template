import 'package:__brick__/app/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  
  /// 配置App字体大小
  final TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
    ),
    //...中间省略 healin3 ~ headline5,只是配置不一样
    displaySmall: TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
        fontSize: 8.sp, fontWeight: FontWeight.normal, color: Colors.black),
  );

  ThemeData theme({bool isdark = false,Color? primary}) {
    var colorScheme = isdark ? darkColorScheme : lightColorScheme;
    colorScheme = colorScheme.copyWith(primary: primary,secondary: primary);
    return ThemeData(
        useMaterial3: false,
        colorScheme: colorScheme,
        textTheme: textTheme);
  }
}