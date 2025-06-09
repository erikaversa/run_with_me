import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Restituisce un colore in base ai valori di BPM e VO₂ %
/// Donna: maxHR = 226 - età (stima standard)
Color getZoneColor(int heartRate, int vo2Percent) {
  final isHeartOk = heartRate >= 90 && heartRate <= 175;
  final isVo2Ok = vo2Percent >= 50 && vo2Percent <= 90;

  if (isHeartOk && isVo2Ok) {
    return AppColors.green;
  } else {
    return AppColors.red;
  }
}
