import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/model/topic_local/topic_local.dart';

part 'app_state.freezed.dart';

@immutable
@freezed
class AppState with _$AppState {
  const factory AppState({TopicLocal? topicLocal, ThemeData? themeData}) =
      _AppState;
  factory AppState.initial() => const AppState();
}
