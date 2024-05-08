import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/custom_stream_builder.dart';
import 'package:vpn/utils/spaces.dart';
import 'package:vpn/widgets/custom_buttom.dart';
import 'package:vpn/widgets/custom_field.dart';
import 'package:vpn/widgets/custom_scaffold.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'bloc.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpBloc bloc = SignUpBloc();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    bloc.init(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: bloc,
        builder: (context, ScreenState state) {
          final s = S.of(context);
          return CustomScaffold(
              body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 43.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.map.image(
                  color: BC.green1,
                  width: 180,
                  height: 110,
                  fit: BoxFit.cover,
                ),
                Space.h32,
                Text(s.sign_up, style: BS.bold24),
                Space.h24,
                CustomField(
                  controller: emailController,
                  text: s.email,
                  isEmailField: true,
                  keyboardType: TextInputType.emailAddress,
                ),
                Space.h16,
                CustomField(
                  controller: passwordController,
                  text: s.password,
                  keyboardType: TextInputType.visiblePassword,
                  isEmailField: false,
                  isShowPassword: state.isShowPassword,
                  onTap: () {
                    bloc.changePasswordVisibility();
                  },
                ),
                Space.h24,
                CustomButtonGray(
                  onTap: () {
                    bloc.showDialogRecaptcha(context, emailController.text,
                        passwordController.text, bloc);
                    // bloc.signUp(context, emailController.text, passwordController.text);
                  },
                  text: s.sign_up,
                ),
                Space.h32,
                Text(s.by_creating_an_account,
                    style: BS.reg13.apply(color: BC.green1)),
                Space.h4,
                CustomTextButton(
                  onTap: () => bloc.goTerms(context),
                  text: s.terms_of_service,
                ),
                Space.h16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${s.already_have_an_account} ',
                        style: BS.reg13.apply(color: BC.green1)),
                    CustomTextButton(
                      onTap: () => bloc.goLogin(context),
                      text: s.log_in,
                    )
                  ],
                )
              ],
            ),
          ));
        });
  }
}
