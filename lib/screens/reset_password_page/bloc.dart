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

  void init(BuildContext context) async {
    setState(ScreenState(context: context));
  }

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

  void resetPassword( String email, String captcha) async {
    try {
      final model = SignUpModel(lang: 'en', email: email, gRecaptchaResponse: captcha);
      await authApi.resetPassword(model);
        currentState.context?.router.push(const AuthRoute());

    } on Exception catch (e) {
      if (currentState.context?.mounted ?? false) {
        SnackBarService.showSnackBar(
            currentState.context!, e.toString().replaceAll('Exception: ', ''), true);
        currentState.context?.router.pop();
      }
    }
  }

  void goBack(BuildContext context) {
    context.router.pop();
  }
}

class ScreenState {
  final bool loading;
  BuildContext? context;

  ScreenState({this.loading = false, this.context});

  ScreenState copyWith({bool? loading, BuildContext? context}) {
    return ScreenState(
        loading: loading ?? this.loading, context: context ?? this.context);
  }
}
