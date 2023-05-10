import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kucalator/data/model/user_local/user_model_local.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/cache_manager.dart';
import 'main_state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;
import 'package:fluttertoast/fluttertoast.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState.initial());
  final ImagePicker imagePicker = ImagePicker();
  final CacheManager _cacheManager = CacheManager.instance;
  void init() async {
    // _cacheManager.addTopic(TopicLocal(
    //     title: "Dark mode",
    //     primaryColor: const Color(0xffFF6B6B),
    //     backgroundColor: const Color(0xff22252D),
    //     textColor: Colors.white));
    // final topic = await _cacheManager.getTopic();
    // emit(state.copyWith(topic: topic));
    UserLocal? userLocal = await _cacheManager.getUserCached();
    if (userLocal != null) {
      emit(state.copyWith(userLocal: userLocal));
    }
  }

  getFromCamera() async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      _cacheManager.addUserToCached(UserLocal(image: imageBytes));
      emit(state.copyWith(userLocal: UserLocal(image: imageBytes)));
    }
  }

  handlePickImage(ImageSource source) async {
    // isLoadingUpdateImage(true);
    final permission =
        source == ImageSource.camera ? Permission.camera : ImageSource.gallery;

    final pickedFile = await imagePicker.pickImage(
      source: source,
    );
    if (pickedFile == null) {
      return;
    }

    final fileExtension = p.extension(pickedFile.path).replaceAll('.', '');
    if (fileExtension != 'png' &&
        fileExtension != 'jpg' &&
        fileExtension != 'jpeg') {
      if (pickedFile != null) {
        Fluttertoast.showToast(msg: "định dạng ảnh không được hỗ trợ");
      }
    } else {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      _cacheManager.addUserToCached(UserLocal(image: imageBytes));
      emit(state.copyWith(userLocal: UserLocal(image: imageBytes)));
    }
  }
}
