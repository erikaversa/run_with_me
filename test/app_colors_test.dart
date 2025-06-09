import 'package:flutter_test/flutter_test.dart';
import 'package:run_with_me/theme/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  group('AppColors', () {
    test('green color is correct', () {
      expect(AppColors.green, const Color(0xFF10B981));
    });
    test('red color is correct', () {
      expect(AppColors.red, const Color(0xFFEF4444));
    });
    test('background color is correct', () {
      expect(AppColors.background, const Color.fromARGB(255, 198, 201, 106));
    });
    test('textPrimary color is correct', () {
      expect(AppColors.textPrimary, const Color.fromRGBO(0, 1, 2, 1));
    });
  });
}
