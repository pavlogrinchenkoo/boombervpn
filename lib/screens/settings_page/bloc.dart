import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/utils/bloc_base.dart';

class SettingsBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  SettingsBloc() {
    setState(ScreenState());
  }

  void init() async {}

  void openVpn(bool isOpenVpn) {
    setState(currentState.copyWith(isOpenVpn: !isOpenVpn));
  }

  void changeBlockInternet(bool isBlockInternet) {
    setState(currentState.copyWith(isBlockInternet: !isBlockInternet));
  }

  void changePrimeVpn(bool isPrimeVpn) {
    setState(currentState.copyWith(isPrimeVpn: !isPrimeVpn));
  }

  void changeShowNotification(bool isShowNotification) {
    setState(currentState.copyWith(isShowNotification: !isShowNotification));
  }
}

class ScreenState {
  final bool loading;
  final bool isOpenVpn;
  final bool isBlockInternet;
  final bool isPrimeVpn;
  final bool isShowNotification;

  ScreenState(
      {this.loading = false,
      this.isOpenVpn = false,
      this.isBlockInternet = false,
      this.isPrimeVpn = false,
      this.isShowNotification = false});

  ScreenState copyWith(
      {bool? loading,
      bool? isOpenVpn,
      bool? isBlockInternet,
      bool? isPrimeVpn,
      bool? isShowNotification}) {
    return ScreenState(
        loading: loading ?? this.loading,
        isOpenVpn: isOpenVpn ?? this.isOpenVpn,
        isBlockInternet: isBlockInternet ?? this.isBlockInternet,
        isPrimeVpn: isPrimeVpn ?? this.isPrimeVpn,
        isShowNotification: isShowNotification ?? this.isShowNotification);
  }
}
