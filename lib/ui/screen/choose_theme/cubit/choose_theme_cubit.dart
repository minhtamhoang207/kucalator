import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../data/cache_manager.dart';
import '../../../../data/model/topic_local/current_topic.dart';
import '../../../../injection.dart';
import '../../../app_cubit.dart';
import '../../../services/ThemePreferences.dart';
import '../../../theme/theme_cubit.dart';
import 'choose_theme_state.dart';

class ChooseThemeCubit extends Cubit<ChooseThemeState> {
  ChooseThemeCubit() : super(ChooseThemeState.initial());
  final AppCubit appCubit = getIt.get<AppCubit>();
  final ThemeCubit _themeCubit = getIt.get<ThemeCubit>();
  final CacheManager _cacheManager = CacheManager.instance;

  Future<void> init() async {
    CurrentTopic topic =
        await _cacheManager.getCurrnetTopicCached() ?? CurrentTopic();
    if (topic.currentTheme != null) {
      // if (topic.currentTheme == ThemeData.light())
      //   emit(state.copyWith(currentTheme: "Light"));
      // if (topic.currentTheme == ThemeData.dark())
      emit(state.copyWith(currentTheme: topic.currentTheme!));
    }
  }

  Future<void> selectTheme(String theme) async {
    ThemeData themeData = ThemeData.light();
    state.listTheme.forEach((key, value) {
      if (key == theme) {
        themeData = value;
      }
    });
    CurrentTopic topic =
        await _cacheManager.getCurrnetTopicCached() ?? CurrentTopic();
    topic = topic.copyWith(currentTheme: theme);
    await _cacheManager.addCurrnetTopicToCached(topic);
    ThemePreferences().switchTheme(theme);
    emit(state.copyWith(currentTheme: theme));
  }
}
