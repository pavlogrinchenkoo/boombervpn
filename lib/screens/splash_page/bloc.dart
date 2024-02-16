import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/api/cache.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/utils/bloc_base.dart';

class SplashBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  Cache cache = Cache();

  SplashBloc() {
    setState(ScreenState());
  }

  void init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    final user = await cache.getUser();
    if(user != null) {
     if(context.mounted) context.router.replaceAll([const HomeRoute()]);
    } else {
      if(context.mounted) context.router.replaceAll([const AuthRoute()]);
    }

  }
}

class ScreenState {
  final bool loading;

  ScreenState({this.loading = false});

  ScreenState copyWith({bool? loading}) {
    return ScreenState(loading: loading ?? this.loading);
  }
}