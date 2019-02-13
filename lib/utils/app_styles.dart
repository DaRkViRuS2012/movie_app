import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';

class AppStyles {
  static final STYLE_TITLE = TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      fontFamily: 'Robot',
      shadows: [AppColors.shadow]);

  static final STYLE_SUBTITLE = TextStyle(
      color: AppColors.lightWhite,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      shadows: [AppColors.shadow]);
}
