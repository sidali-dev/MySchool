import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/// Custom Class for Light & Dark Text Themes
class SCheckboxTheme {
  SCheckboxTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(SSizes.xs)),
    checkColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SColors.white;
      } else {
        return SColors.black;
      }
    }),
    fillColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );

  /// Customizable Dark Text Theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(SSizes.xs)),
    checkColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SColors.white;
      } else {
        return SColors.black;
      }
    }),
    fillColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return SColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
