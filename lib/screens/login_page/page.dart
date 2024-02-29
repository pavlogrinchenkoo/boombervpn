import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/custom_stream_builder.dart';
import 'package:vpn/utils/spaces.dart';
import 'package:vpn/widgets/custom_buttom.dart';
import 'package:vpn/widgets/custom_field.dart';
import 'package:vpn/widgets/custom_scaffold.dart';

import 'bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc bloc = LoginBloc();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    bloc.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    // TODO везде пропписать тип
    return CustomStreamBuilder<ScreenState>(
        bloc: bloc,
        builder: (context, state) {
          return CustomScaffold(
              body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 43),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(s.log_in, style: BS.bold24),
                Space.h24,
                CustomField(
                  controller: emailController,
                  text: s.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                Space.h16,
                CustomField(
                  controller: passwordController,
                  text: s.password,
                  keyboardType: TextInputType.visiblePassword,
                ),
                Space.h24,
                CustomButtonGray(
                  onTap: () => bloc.showDialogRecaptcha(
                      context, emailController.text, passwordController.text, bloc),
                  text: s.log_in,
                ),
                Space.h32,
                CustomTextButton(
                  onTap: () => bloc.goResetPassword(context),
                  text: s.forgot_password,
                ),
                Space.h16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${s.dont_have_an_account} ',
                        style: BS.reg13.apply(color: BC.white)),
                    CustomTextButton(
                      onTap: () => bloc.goSignUp(context),
                      text: s.Create_an_account,
                    )
                  ],
                )
              ],
            ),
          ));
        });
  }
}
