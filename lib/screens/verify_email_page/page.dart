import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/api/auth/dto.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/custom_stream_builder.dart';
import 'package:vpn/utils/spaces.dart';
import 'package:vpn/widgets/custom_buttom.dart';
import 'package:vpn/widgets/custom_scaffold.dart';
import 'bloc.dart';

@RoutePage()
class VerifyEmailPage extends StatefulWidget {
  final SignUpModel signUpModel;

  const VerifyEmailPage({super.key, required this.signUpModel});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late VerifyEmailBloc bloc = VerifyEmailBloc();

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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 43.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.please_verify_your_email,
                    style: BS.bold24,
                  ),
                  Space.h24,
                  Assets.images.group1371.image(
                    width: 170,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                  Space.h32,
                  CustomButtonGray(
                    onTap: () => bloc.goLogin(context),
                    text: s.verified,
                  ),
                  Space.h24,
                  CustomButtonBlack(
                    onTap: () => bloc.resendEmail(widget.signUpModel),
                    text: s.resend,
                  ),
                  Space.h24,
                  CustomTextButton(
                    onTap: () => bloc.goSignUp(context),
                    text: s.sign_up_with_a_different_email,
                  )
                ],
              ),
            ),
          );
        });
  }
}
