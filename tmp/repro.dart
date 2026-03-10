import 'package:flutter/material.dart';
import 'package:cashku/core/theme/app_typography.dart';

void main() {
  final style = AppTypography.h3.copyWith(fontWeight: FontWeight.bold);
  print(style.fontWeight);
}
