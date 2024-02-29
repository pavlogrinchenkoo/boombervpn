import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpn/screens/login_page/bloc.dart';
import 'package:vpn/screens/reset_password_page/bloc.dart';
import 'package:vpn/screens/signup_page/bloc.dart';
import 'package:vpn/style.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class DialogRecaptcha extends StatefulWidget {
  final String email;
  final String password;
  final String page;
  final SignUpBloc? signUpBloc;
  final LoginBloc? loginBloc;
  final ResetPasswordBloc? resetPasswordBloc;
  const DialogRecaptcha({super.key, required this.email, required this.password, required this.page, this.signUpBloc, this.loginBloc, this.resetPasswordBloc});

  @override
  State<DialogRecaptcha> createState() => _DialogRecaptchaState();
}

class _DialogRecaptchaState extends State<DialogRecaptcha> {
  late WebViewControllerPlus webController;

  @override
  void initState() {
    webController = WebViewControllerPlus()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            webController.onLoaded((msg) {
              webController.getWebViewHeight().then((value) {
                var height = int.parse(value.toString()).toDouble();
                if (kDebugMode) {
                  print("Height is: $value");
                }
              });
            });
          },
        ),
      )
      ..loadFlutterAssetServer('assets/webpages/index.html');
    webController.addJavaScriptChannel('Captcha', onMessageReceived: (message) {
      if(widget.page == 'signup') {
     widget.signUpBloc?.signUp(context, widget.email, widget.password, message.message);
      } else if(widget.page == 'resetPassword') {
        widget.resetPasswordBloc?.resetPassword( widget.email, message.message);
      } else if(widget.page == 'login') {
        widget.loginBloc?.login(context, widget.email, widget.password, message.message);
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
          color: BC.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          )),
      child: Center(
        child: WebViewWidget(
          controller: webController,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () {
                print('adadadadadad');
                return EagerGestureRecognizer();
              },
            ),
          },
        ),
      ),
    );
  }
}
