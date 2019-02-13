import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';

double FONT_LARGE = 22.0;
double FONT_MEDIUM = 18.0;

final STYLE_TITLE = TextStyle(
    color: Colors.white,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: 'Robot',
    shadows: [AppColors.shadow]);

final STYLE_SUBTITLE = TextStyle(
    color: AppColors.lightWhite,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    shadows: [AppColors.shadow]);
