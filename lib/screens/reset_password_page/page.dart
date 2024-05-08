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
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late ResetPasswordBloc bloc = ResetPasswordBloc();
  TextEditingController controller = TextEditingController();

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
                  Text(s.reset_password, style: BS.bold24),
                  Space.h24,
                  CustomField(controller: controller, text: s.email, keyboardType: TextInputType.emailAddress),
                  Space.h24,
                  CustomButtonGray(
                    onTap: () => bloc.showDialogRecaptcha(context, controller.text, bloc),
                    text: s.send,
                  ),
                  Space.h32,
                  Text(s.remembered_your_password,
                      style: BS.reg13.apply(color: BC.green1)),
                  Space.h8,
                  CustomTextButton(
                    onTap: () => bloc.goBack(context),
                    text: s.log_in,
                  )
                ],
              ),
            ),
          );
        });
  }
}
