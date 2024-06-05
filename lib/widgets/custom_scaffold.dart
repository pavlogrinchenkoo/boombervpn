import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/custom_stream_builder.dart';
import 'package:vpn/utils/scafold_bloc.dart';

final ScaffoldBloc scaffoldBloc = ScaffoldBloc();

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {this.appBar,
      required this.body,
      this.bottomNavigationBar,
      super.key,
      this.resizeToAvoidBottomInset,
      this.showGoPro,
      this.backgroundColor, this.showAppBar = false, this.isHomePage, this.showLine});

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final String? showGoPro;
  final Color? backgroundColor;
  final bool? showAppBar;
  final bool? isHomePage;
  final bool? showLine;

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: scaffoldBloc,
        builder: (BuildContext context, ScreenState state) {
          return Scaffold(
            resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
            backgroundColor: backgroundColor ?? BC.white,
            bottomNavigationBar: bottomNavigationBar,
            body: SafeArea(
              bottom: false,
                child: Column(
              children: [
              if(showAppBar ?? false)  Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.transparent
                  ),
                  child: Row(
                    children: [
                      Text('Bomber VPN', style: BS.bold24.apply(color: (isHomePage ?? false) ?  BC.white : BC.black)),
                      const Spacer(),
                      if (showGoPro != null)
                        InkWell(
                            onTap: () =>
                                context.router.push(const GoProRoute()),
                            child: (state.isVip)
                                ? Assets.icons.pro.svg()
                                : Assets.icons.proYelov.svg(
                              colorFilter: (isHomePage ?? false) ? ColorFilter.mode(BC.white, BlendMode.srcIn) : null,
                            )),
                    ],
                  ),
                ),
                ( (showLine ?? false)) ? Container(
                  width: MediaQuery.of(context).size.width - 48,
                  height: 1,
                  color: BC.lightGrey.withOpacity(0.3),
                ) : const SizedBox(),
                Expanded(child: body),
              ],

            )),
          );
        });
  }
}
