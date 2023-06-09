import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kucalator/ui/theme/constant.dart';

import '../../../data/cache_manager.dart';
import '../../../data/firebase/firebase_manager.dart';
import '../../../data/model/user_local/user_model_local.dart';
import '../../router/router.gr.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  final FirebaseManager _firebaseManager = FirebaseManager();
  final CacheManager _cacheManager = CacheManager.instance;
  Future<void> init() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 60),
      minimumFetchInterval: const Duration(seconds: 1),
    ));
    await _remoteConfig.ensureInitialized();
    await _remoteConfig.activate();
    await _remoteConfig.fetchAndActivate().then((value) {
      // checkFirtLoad(showSignUp: _remoteConfig.getBool('show_sign_up'));
    });
  }

  @override
  initState() {
    super.initState();
    pushPage();
  }

  pushPage() async {
    Timer(Duration(milliseconds: 500), () {
      context.router.pushAll([const MainPage()]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            alignment: Alignment.center,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/splash/icon_splash1.svg",
                        width: 50.w,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      SvgPicture.asset(
                        "assets/images/splash/icon_splash2.svg",
                        width: 50.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/splash/icon_splash3.svg",
                        width: 50.w,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      SvgPicture.asset(
                        "assets/images/splash/icon_splash4.svg",
                        width: 50.w,
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
