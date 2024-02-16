import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/style.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {this.appBar,
      required this.body,
      this.bottomNavigationBar,
      super.key,
      this.resizeToAvoidBottomInset, this.showGoPro});

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final String? showGoPro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      backgroundColor: BC.black,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: BC.black,
            ),
            child: Row(
              children: [
                Text('Bomber VPN', style: BS.bold24),
                const Spacer(),

               if(showGoPro != null) InkWell(
                    onTap: () => context.router.push(const GoProRoute()),
                    child: Assets.icons.proYelov.svg()),
              ],
            ),
          ),
          Expanded(child: body),
        ],
      )),
    );
  }
}
