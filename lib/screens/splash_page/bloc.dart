import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vpn/api/cache.dart';
import 'package:vpn/api/locations/dto.dart';
import 'package:vpn/api/locations/request.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/utils/bloc_base.dart';

class SplashBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  Cache cache = Cache();

  SplashBloc() {
    setState(ScreenState());
  }

  void init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    final user = await cache.getUser();
    if (user != null) {
      if (context.mounted) context.router.replaceAll([const HomeRoute()]);
    } else {
      if (context.mounted) context.router.replaceAll([const AuthRoute()]);
    }
    final firstLaunch = await cache.getFirstLaunch();
    if (!firstLaunch) {
      getCountry();
      cache.saveFirstLaunch(true);
    }
  }

  Future<void> getCountry() async {
    try {
      Network n = Network("http://ip-api.com/json");
      final locationSTR = (await n.getData());
      final locationx = jsonDecode(locationSTR);
      final latLong = LatLon(lat: locationx["lat"], lon: locationx["lon"]);
      await cache.saveLocation(latLong);
    } on Exception catch (e) {
      print(e);
    }
  }
}

class ScreenState {
  final bool loading;

  ScreenState({this.loading = false});

  ScreenState copyWith({bool? loading}) {
    return ScreenState(loading: loading ?? this.loading);
  }
}
