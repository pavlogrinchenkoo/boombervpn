import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/utils/bloc_base.dart';

// TODO удолить не исп импорті

class GoProBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  GoProBloc() {
    setState(ScreenState());
  }

  void init() async {}
}

class ScreenState {
  final bool loading;

  ScreenState({this.loading = false});

  ScreenState copyWith({bool? loading}) {
    return ScreenState(loading: loading ?? this.loading);
  }
}