import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/api/auth/dto.dart';
import 'package:vpn/api/auth/request.dart';
import 'package:vpn/api/cache.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/utils/bloc_base.dart';

class ProfileBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  AuthApi authApi = AuthApi();
  final Cache cache = Cache();
  ProfileBloc() {
    setState(ScreenState());
  }

  void init() async {
    final isVip = await cache.getSubscribe();
    final user = await authApi.getUser();
      setState(ScreenState(user: user, loading: true, isVip: isVip));
  }

  void goPro(BuildContext context) {
    context.router.push(const GoProRoute());
  }
}

class ScreenState {
  final bool loading;
  final bool isVip;
  final UserResponseModel? user;

  ScreenState({this.loading = false, this.isVip = false, this.user});

  ScreenState copyWith({bool? loading, bool? isVip, UserResponseModel? user}) {
    return ScreenState(
        loading: loading ?? this.loading,
        isVip: isVip ?? this.isVip,
        user: user ?? this.user);
  }
}
