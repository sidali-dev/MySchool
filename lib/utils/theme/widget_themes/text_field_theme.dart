import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class SSextFormFieldTheme {
  SSextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationSheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: SColors.primary,
    suffixIconColor: SColors.primary,
    // constraints: const BoxConstraints.expand(height: SSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
        fontSize: 16, color: SColors.black, fontWeight: FontWeight.w700),
    hintStyle: const TextStyle().copyWith(
        fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w700),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: SColors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(width: 1, color: SColors.primary),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(width: 1, color: SColors.primary),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(width: 2, color: SColors.primary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(width: 1, color: SColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(width: 2, color: SColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationSheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: SColors.primary,
    suffixIconColor: SColors.primary,
    // constraints: const BoxConstraints.expand(height: SSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
        color: SColors.white, fontSize: 16, fontWeight: FontWeight.w700),
    hintStyle: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.w700, color: SColors.white),
    floatingLabelStyle: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: SColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(width: 1, color: SColors.primary),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(width: 1, color: SColors.primary),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(width: 2, color: SColors.primary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(width: 1, color: SColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(width: 2, color: SColors.warning),
    ),
  );
}
