import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/api/cache.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/screens/profile_page/page.dart';
import 'package:vpn/utils/bloc_base.dart';
import 'package:vpn/widgets/custom_scaffold.dart';

class GoProBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  final Cache cache = Cache();

  GoProBloc() {
    setState(ScreenState());
  }

  void init() async {}

  void subscribe(BuildContext context) async {
    // cache.saveSubscribe(true);
    // scaffoldBloc.init();
    // blocProfile.init();
    // if (context.mounted) {
    //   context.router.push(const HomeRoute());
    // }
  }
}

class ScreenState {
  final bool loading;

  ScreenState({this.loading = false});

  ScreenState copyWith({bool? loading}) {
    return ScreenState(loading: loading ?? this.loading);
  }
}
