import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/api/auth/dto.dart';
import 'package:vpn/api/locations/dto.dart';
import 'package:vpn/screens/auth_page/page.dart';
import 'package:vpn/screens/dashboards/page.dart';
import 'package:vpn/screens/go_pro_page/page.dart';
import 'package:vpn/screens/home_page/page.dart';
import 'package:vpn/screens/list_locations_page/page.dart';
import 'package:vpn/screens/login_page/page.dart';
import 'package:vpn/screens/profile_page/page.dart';
import 'package:vpn/screens/reset_password_page/page.dart';
import 'package:vpn/screens/settings_page/page.dart';
import 'package:vpn/screens/signup_page/page.dart';
import 'package:vpn/screens/splash_page/page.dart';
import 'package:vpn/screens/verify_email_page/page.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/', page: SplashRoute.page),
    AutoRoute(path: '/auth', page: AuthRoute.page),
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/signup', page: SignUpRoute.page),
    AutoRoute(path: '/reset-password', page: ResetPasswordRoute.page),
    AutoRoute(path: '/verify-email', page: VerifyEmailRoute.page),
    AutoRoute(path: '/dashboards', page: DashBoardRoute.page, children: [
      AutoRoute(path: 'profile', page: ProfileRoute.page),
      AutoRoute(path: 'home', page: HomeRoute.page),
      AutoRoute(path: 'settings', page: SettingsRoute.page),
      AutoRoute(path: 'list-locations', page: ListLocationsRoute.page),
    ]),
    AutoRoute(path: '/go-pro', page: GoProRoute.page),
  ];
}

// dart run build_runner watch
// dart run build_runner build
