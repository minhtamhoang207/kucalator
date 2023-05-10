import 'dart:ffi';
import 'dart:typed_data';

import 'package:hive/hive.dart';

import '../../cache_manager.dart';

part 'user_model_local.g.dart';

@HiveType(typeId: CacheManager.userLocal)
class UserLocal extends HiveObject {
  @HiveField(0)
  Uint8List image;

  UserLocal({required this.image});
}
