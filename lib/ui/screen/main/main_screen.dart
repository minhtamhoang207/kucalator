import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kucalator/ui/screen/main/cubit/main_cubit.dart';
import 'package:kucalator/ui/screen/main/cubit/main_state.dart';
import 'package:kucalator/ui/screen/main/media_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../data/cache_manager.dart';
import '../../../data/model/status_click/status_click.dart';
import '../../../icons/assets.gen.dart';
import '../../router/router.gr.dart';
import '../../theme/constant.dart';
import '../../theme/theme.dart';
import '../calculator/calculator_screen.dart';
import '../change_money_screen/change_money_screen.dart';
import '../choose_theme/choose_theme_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late bool showPopup = false;
  final _remoteConfig = FirebaseRemoteConfig.instance;
  final CacheManager _cacheManager = CacheManager.instance;
  String loginUrl = '';
  String signUpUrl = '';
  String supportUrl = '';
  String linkImage = "";
  String linkImagePopup = "";
  final List<Widget> _widgetOptions = <Widget>[
    const CalculatorScreen(),
    const ChangeMoneyScreen(),
    const ChooseThemeScreen()
  ];

  final List<String> _title = [
    'Máy tính',
    'Chuyển đổi tiền tệ',
    'Chủ đề',
    'Đăng xuất'
  ];

  final List<String> _icon = [
    Assets.images.icCalculator.path,
    Assets.images.icCurrencyConvert.path,
    Assets.images.icTheme.path,
    Assets.images.icLogout.path
  ];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 60),
      minimumFetchInterval: const Duration(seconds: 1),
    ));
    await _remoteConfig.ensureInitialized();
    await _remoteConfig.activate();
    await _remoteConfig.fetchAndActivate().then((value) {
      showPopup = _remoteConfig.getBool('show_sign_up');
      loginUrl = _remoteConfig.getString('login_url');
      signUpUrl = _remoteConfig.getString('signup_url');
      supportUrl = _remoteConfig.getString('support_url');
      linkImage = _remoteConfig.getString("link_image");
      linkImagePopup = _remoteConfig.getString("popup_image_url");
    });
    StatusClick? status = await _cacheManager.getStatusClickCached();
    if (showPopup == true && linkImage != "") {
      _showMaterialDialog();
    }
  }

  void _showMaterialDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent.withOpacity(0),
          child: Container(
            width: 400.h,
            height: 300.h,
            decoration: BoxDecoration(color: Colors.transparent.withOpacity(0)),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: GestureDetector(
                    onTap: () async {
                      final url = linkImagePopup;
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        throw 'Could not launch $url';
                      }
                      Navigator.pop(context);
                    },
                    child: CachedNetworkImage(
                      imageUrl: linkImage,
                      imageBuilder: (context, imageProvider) => Container(
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                  Colors.white, BlendMode.colorBurn)),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[100]),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..init(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: appBarColor,
                // backgroundColor: backgroundColor,
                iconTheme: IconThemeData(color: textAppBarColor),
                title: Text(
                  _title[_selectedIndex],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textAppBarColor),
                ),
                centerTitle: false,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
              ),
              // backgroundColor: backgroundColor,
              drawer: Drawer(
                backgroundColor: backgroundColor,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    SizedBox(
                      height: 112.h,
                      child: DrawerHeader(
                          decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20))),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showPickerModalPopup(context);
                                },
                                child: state.userLocal != null
                                    ? CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          clipBehavior: Clip.antiAlias,
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            child: Image.memory(
                                              state.userLocal!.image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    // Container(
                                    //     width: 40.w,
                                    //     height: 40.w,
                                    //     decoration: BoxDecoration(
                                    //         // shape: BoxShape.circle,
                                    //         image: DecorationImage(image: AssetImage) ,
                                    //         borderRadius:
                                    //             BorderRadius.circular(50)),
                                    //     child: Image.memory(
                                    //       state.userLocal!.image,
                                    //       fit: BoxFit.fill,
                                    //     ),
                                    //   )
                                    : const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.person,
                                            color: Colors.grey),
                                      ),
                              ),
                              SizedBox(width: 16.w),
                              const Flexible(
                                child: Text(
                                  'Xin chào',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          )),
                    ),
                    Column(
                      children: List.generate(3, (index) {
                        return ListTile(
                          leading: Image.asset(
                            _icon[index],
                            height: 24,
                            width: 24,
                          ),
                          title: Text(
                            _title[index],
                            style: index != _selectedIndex
                                ? titleStyle.copyWith(
                                    height: 0,
                                    fontSize: 14.sp,
                                    color: textColor)
                                : titleStyle.copyWith(
                                    height: 0,
                                    fontSize: 14.sp,
                                    color: primaryColor),
                          ),
                          selected: _selectedIndex == index,
                          onTap: () async {
                            if (index == 3) {
                              ///TODO: implement logout
                              await _cacheManager.deleteUserToCached();
                              _cacheManager.addStatusClickToCached(null);
                              context.router.push(const SplashPage());
                            } else {
                              _onItemTapped(index);
                            }
                          },
                        );
                      }),
                    )
                  ],
                ),
              ),
              body: _widgetOptions.elementAt(_selectedIndex));
        },
      ),
    );
  }

  Future<void> _showPickerModalPopup(BuildContext context) {
    return showBarModalBottomSheet(
      context: context,
      //expand: true,
      builder: (BuildContext context1) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          height: 100.h,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: kDefaultPaddingWidthScreen,
              ),
              MediaButtonWidget(
                  icon: Icons.photo,
                  title: 'Thêm hình ảnh',
                  onTap: () {
                    context
                        .read<MainCubit>()
                        .handlePickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  }),
              SizedBox(
                width: kDefaultPaddingWidthScreen,
              ),
              MediaButtonWidget(
                  icon: Icons.camera_alt_rounded,
                  title: 'Chụp ảnh',
                  onTap: () {
                    context.read<MainCubit>().getFromCamera();
                    Navigator.pop(context);
                  }),
              SizedBox(
                width: kDefaultPaddingWidthScreen,
              ),
            ],
          ),
        );
      },
    );
  }
}
