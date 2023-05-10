// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../screen/calculator/calculator_screen.dart' as _i3;
import '../screen/choose_theme/choose_theme_screen.dart' as _i4;
import '../screen/main/main_screen.dart' as _i2;
import '../screen/splash/splash_screen.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SplashPage.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
      );
    },
    MainPage.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.MainScreen(),
      );
    },
    Calculator.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.CalculatorScreen(),
      );
    },
    ChooseTheme.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.ChooseThemeScreen(),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          SplashPage.name,
          path: '/',
        ),
        _i5.RouteConfig(
          MainPage.name,
          path: '/main',
        ),
        _i5.RouteConfig(
          Calculator.name,
          path: '/calculator',
        ),
        _i5.RouteConfig(
          ChooseTheme.name,
          path: '/choose_theme',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashPage extends _i5.PageRouteInfo<void> {
  const SplashPage()
      : super(
          SplashPage.name,
          path: '/',
        );

  static const String name = 'SplashPage';
}

/// generated route for
/// [_i2.MainScreen]
class MainPage extends _i5.PageRouteInfo<void> {
  const MainPage()
      : super(
          MainPage.name,
          path: '/main',
        );

  static const String name = 'MainPage';
}

/// generated route for
/// [_i3.CalculatorScreen]
class Calculator extends _i5.PageRouteInfo<void> {
  const Calculator()
      : super(
          Calculator.name,
          path: '/calculator',
        );

  static const String name = 'Calculator';
}

/// generated route for
/// [_i4.ChooseThemeScreen]
class ChooseTheme extends _i5.PageRouteInfo<void> {
  const ChooseTheme()
      : super(
          ChooseTheme.name,
          path: '/choose_theme',
        );

  static const String name = 'ChooseTheme';
}
