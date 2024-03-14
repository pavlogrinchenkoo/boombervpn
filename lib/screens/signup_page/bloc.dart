import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/api/auth/dto.dart';
import 'package:vpn/api/auth/request.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/utils/bloc_base.dart';
import 'package:vpn/widgets/dialog_recaptcha.dart';
import 'package:vpn/widgets/snack_bar.dart';

class SignUpBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  AuthApi authApi = AuthApi();

  SignUpBloc() {
    setState(ScreenState());
  }

  void init(BuildContext context) async {}

  void showDialogRecaptcha(BuildContext context, String email, String password,
      SignUpBloc bloc) async {
    if (email.isNotEmpty || password.isNotEmpty) {
      if (password.length <= 8) {
        SnackBarService.showSnackBar(
            context, 'Password must be more than 8 characters', true);
      } else {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return DialogRecaptcha(
                email: email,
                password: password,
                page: 'signup',
                signUpBloc: bloc,
              );
            });
      }
    } else {
      SnackBarService.showSnackBar(
          context, 'Please enter email or password', true);
    }
  }

  void signUp(BuildContext context, String email, String password,
      String captcha) async {
    // context.router.pop();
    try {
      final model = SignUpModel(
          lang: 'en',
          email: email,
          password: password,
          passwordReEntrered: password,
          gRecaptchaResponse: captcha);
      await authApi.signUp(model);
      if (context.mounted) {
        context.router.push(VerifyEmailRoute(signUpModel: model));
      }
    } on Exception catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context, e.toString().replaceAll('Exception: ','' ), true);
        context.router.pop();
      }
      print(e);
    }
  }

  void goLogin(BuildContext context) {
    context.router.push(const LoginRoute());
  }

  void goTerms(BuildContext context) {}

  void changePasswordVisibility() {
    setState(currentState.copyWith(isShowPassword: !(currentState.isShowPassword)));
  }
}

class ScreenState {
  final bool isShowPassword;
  ScreenState({this.isShowPassword = false});

  ScreenState copyWith({bool? isShowPassword}) {
    return ScreenState(isShowPassword: isShowPassword ?? this.isShowPassword);
  }
}
