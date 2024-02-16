import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/utils/bloc_base.dart';

class AuthBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  AuthBloc() {
    setState(ScreenState());
  }

  void init(BuildContext context) async {
  }

  void goSignUp(BuildContext context) {
    context.router.push(const SignUpRoute());
  }

  void goLogIn(BuildContext context) {
    context.router.push(const LoginRoute());
  }
}

class ScreenState {
  final bool loading;

  ScreenState({this.loading = false});

  ScreenState copyWith({bool? loading}) {
    return ScreenState(loading: loading ?? this.loading);
  }
}
