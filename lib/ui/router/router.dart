import 'package:auto_route/auto_route.dart';
import 'package:auto_route/annotations.dart';

import '../screen/calculator/calculator_screen.dart';
import '../screen/choose_theme/choose_theme_screen.dart';
import '../screen/main/main_screen.dart';

import '../screen/splash/splash_screen.dart';
import 'app_router.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
        page: SplashScreen,
        name: "SplashPage",
        path: AppRoutes.splashScreen,
        initial: true),
    AutoRoute(page: MainScreen, name: "MainPage", path: AppRoutes.main),
    AutoRoute(
        page: CalculatorScreen, name: "Calculator", path: AppRoutes.calculator),
    AutoRoute(
        page: ChooseThemeScreen,
        name: "ChooseTheme",
        path: AppRoutes.chooseTheme),
  ],
)
class $AppRouter {}
