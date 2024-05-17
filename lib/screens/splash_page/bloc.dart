import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
    final location = await cache.getLocation();
    // cache.removeLocation();
    if (!firstLaunch && location.longitude == 1 && location.latitude == 1) {
      getCountry();
      cache.saveFirstLaunch(true);
    }
  }

  Future<void> getCountry() async {
    try {
      final hasPermission = await _determinePosition();
      LatLon latLong;
      if (hasPermission) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium);
        latLong = LatLon(lat: position.latitude, lon: position.longitude);
      } else {
        Network n = Network("http://ip-api.com/json");
        final locationSTR = (await n.getData());
        final locationx = jsonDecode(locationSTR);
        latLong = LatLon(lat: locationx["lat"], lon: locationx["lon"]);
      }

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

Future<bool> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return false;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return false;
  }

  return true;
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  // return await Geolocator.getCurrentPosition();
}
