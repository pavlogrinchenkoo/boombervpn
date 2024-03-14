import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/api/cache.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/utils/bloc_base.dart';

class SettingsBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  Cache cache = Cache();

  SettingsBloc() {
    setState(ScreenState());
  }

  void init() async {
    final isBlockInternet = await cache.getBlockInternet();
    final isConnectVPN = await cache.getConnectVPN();
    final isShowNotification = await cache.getShowNotification();
    setState(currentState.copyWith(
        isBlockInternet: isBlockInternet,
        isPrimeVpn: isConnectVPN,
        isShowNotification: isShowNotification));
  }

  void changeBlockInternet(bool isBlockInternet, BuildContext context) async {
    final subscribe = await cache.getSubscribe();
    if (subscribe) {
      await cache.saveBlockInternet(!isBlockInternet);
      setState(currentState.copyWith(isBlockInternet: !isBlockInternet));
    } else {
      if (context.mounted) {
        context.router.push(const GoProRoute());
      }
    }
  }

  void changePrimeVpn(bool isPrimeVpn) async {
    await cache.saveConnectVPN(!isPrimeVpn);
    setState(currentState.copyWith(isPrimeVpn: !isPrimeVpn));
  }

  void changeShowNotification(bool isShowNotification) async {
    await cache.saveShowNotification(!isShowNotification);
    setState(currentState.copyWith(isShowNotification: !isShowNotification));
  }

  void logout(BuildContext context) async {
    await cache.removeUser();
    await cache.removeServer();
    await cache.saveBlockInternet(false);
    await cache.saveConnectVPN(false);
    await cache.saveShowNotification(false);
    await cache.saveSubscribe(false);
    if (context.mounted) {
      context.router.replaceAll([const AuthRoute()]);
    }
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
      this.isOpenVpn = true,
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
