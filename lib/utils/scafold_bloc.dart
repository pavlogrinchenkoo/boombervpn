import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/api/auth/dto.dart';
import 'package:vpn/api/auth/request.dart';
import 'package:vpn/api/cache.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/utils/bloc_base.dart';

class ScaffoldBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  AuthApi authApi = AuthApi();
  final Cache cache = Cache();
  ScaffoldBloc() {
    setState(ScreenState());
  }

  void init() async {
    final isVip = await cache.getSubscribe();
    setState(ScreenState(isVip: isVip));
  }

  void goPro(BuildContext context) {
    context.router.push(const GoProRoute());
  }
}

class ScreenState {

  final bool isVip;


  ScreenState({ this.isVip = false});

  ScreenState copyWith({ bool? isVip}) {
    return ScreenState(

        isVip: isVip ?? this.isVip,

    );
  }
}
