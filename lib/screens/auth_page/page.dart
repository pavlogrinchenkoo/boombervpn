import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/custom_stream_builder.dart';
import 'package:vpn/utils/spaces.dart';
import 'package:vpn/widgets/custom_buttom.dart';
import 'package:vpn/widgets/custom_scaffold.dart';
// TODO otstup

import 'bloc.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AuthBloc bloc = AuthBloc();

  @override
  void initState() {
    bloc.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return CustomStreamBuilder(
        bloc: bloc,
        builder: (context, state) {
          return CustomScaffold(
            backgroundColor: BC.blue1,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text(s.logo, style: BS.bold50)),
                Space.h125,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 43),
                  child: Column(
                    children: [
                      CustomButtonGray(
                        onTap: () => bloc.goSignUp(context),
                        text: s.Create_an_account,
                      ),
                      Space.h16,
                      CustomButtonBlack(
                        onTap: () => bloc.goLogIn(context),
                        text: s.Log_in_with_an_existing_account,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
