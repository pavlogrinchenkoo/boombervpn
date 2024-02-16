import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/api/auth/dto.dart';
import 'package:vpn/api/auth/request.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/utils/bloc_base.dart';
import 'package:vpn/widgets/dialog_recaptcha.dart';
import 'package:vpn/widgets/snack_bar.dart';

class ResetPasswordBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  AuthApi authApi = AuthApi();

  ResetPasswordBloc() {
    setState(ScreenState());
  }

  void init(BuildContext context) async {}

  void showDialogRecaptcha(
      BuildContext context, String email, ResetPasswordBloc bloc) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return DialogRecaptcha(
            email: email,
            password: '',
            page: 'resetPassword',
            resetPasswordBloc: bloc,
          );
        });
  }

  void resetPassword(BuildContext context, String email, String captcha) async {
    try {
      final model = SignUpModel(lang: 'en', email: email);
      await authApi.resetPassword(model);
      if (context.mounted) {
        context.router.push(const AuthRoute());
      }
    } on Exception catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(
            context, e.toString().replaceAll('Exception: ', ''), true);
        context.router.pop();
      }
    }
  }

  void goBack(BuildContext context) {
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
