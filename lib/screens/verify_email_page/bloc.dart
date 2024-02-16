import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/api/auth/dto.dart';
import 'package:vpn/api/auth/request.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/utils/bloc_base.dart';
class VerifyEmailBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  AuthApi authApi = AuthApi();
  VerifyEmailBloc() {
    setState(ScreenState());
  }

  void init(BuildContext context) async {}

  void resendEmail(SignUpModel signUpModel) async {
    await authApi.signUp(signUpModel);
  }

  void goLogin(BuildContext context) {
    context.router.replaceAll([const LoginRoute()]);
  }
  void goSignUp(BuildContext context) {
    context.router.pop();
  }
}

class ScreenState {
  final bool loading;

  ScreenState({this.loading = false});

  ScreenState copyWith({bool? loading}) {
    return ScreenState(loading: loading ?? this.loading);
  }
}
