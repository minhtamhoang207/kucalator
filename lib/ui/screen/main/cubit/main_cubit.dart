import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/cache_manager.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState.initial());
  final CacheManager _cacheManager = CacheManager.instance;
  void init() async {
    // _cacheManager.addTopic(TopicLocal(
    //     title: "Dark mode",
    //     primaryColor: const Color(0xffFF6B6B),
    //     backgroundColor: const Color(0xff22252D),
    //     textColor: Colors.white));
    // final topic = await _cacheManager.getTopic();
    // emit(state.copyWith(topic: topic));
  }
}
