import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kucalator/ui/theme/theme.dart';

import '../services/ThemePreferences.dart';

part 'theme_state.freezed.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    String? error,
    required ThemeData themeData,
  }) = _ThemeState;

  factory ThemeState.initial() => ThemeState(
      themeData: ThemePreferences().isDarkMode
          ? (AppThemes.appThemeData[AppTheme.darkTheme] ?? ThemeData.dark())
          : (AppThemes.appThemeData[AppTheme.lightTheme] ?? ThemeData.light()));
}
