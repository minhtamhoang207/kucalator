import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kucalator/ui/theme/theme.dart';
import 'package:kucalator/ui/theme/theme_state.dart';

import '../../data/cache_manager.dart';
import '../../data/model/topic_local/current_topic.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());
  final CacheManager _cacheManager = CacheManager.instance;

  Future<void> init() async {
    ThemeData themeData = ThemeData.light();

    CurrentTopic topic =
        await _cacheManager.getCurrnetTopicCached() ?? CurrentTopic();
    if (topic.currentTheme != null) {
      // "Light": ThemeData.light(), "Dark": ThemeData.dark()}
      if (topic.currentTheme == "Light") {
        emit(state.copyWith(
            themeData: AppThemes.appThemeData[AppTheme.lightTheme] ??
                ThemeData.light()));
      }
      if (topic.currentTheme == "Dark") {
        emit(state.copyWith(
            themeData: AppThemes.appThemeData[AppTheme.darkTheme] ??
                ThemeData.dark()));
      }
    }
  }
}
