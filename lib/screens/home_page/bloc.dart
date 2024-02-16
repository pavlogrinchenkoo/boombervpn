import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vpn/api/cache.dart';
import 'package:vpn/api/locations/dto.dart';
import 'package:vpn/api/locations/request.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/screens/home_page/page.dart';
import 'package:vpn/utils/bloc_base.dart';

import 'widgets/map_animation.dart';

class HomeBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  LocationsApi locationsApi = LocationsApi();
  Cache cache = Cache();

  HomeBloc() {
    setState(ScreenState());
  }

  void init(BuildContext context) async {
    try {
      final locations = await locationsApi.getListLocation();
      final server = await cache.getServer();
      if (server != null) {
        selectServer(server);
      } else {
        selectServer(locations.freeServers?.first ?? Server());
      }
      setState(currentState.copyWith(locations: locations, loading: true));
    } catch (e) {
      if (context.mounted) {
        cache.removeUser();
        context.router.replaceAll([const AuthRoute()]);
      }
    }
  }

  void selectServer(Server server) async {
    setState(currentState.copyWith(server: server, loading: true));
    cache.saveServer(server);
  }

  void goListLocations(BuildContext context) {
    context.router.push(ListLocationsRoute(locations: currentState.locations));
  }

  void connected(BuildContext context, Server server) async {
    final user = await cache.getUser();
    final data = ConnectResponseModel(
      userId: user?.userId,
      bearer: user?.bearer,
      location: server.code,
      type: server.type,
    );
    final connected = await locationsApi.connectLocation(data);
    if (context.mounted) {
      initPlatformState(
          context: context,
          defaultVpnUsername: 'vpn',
          defaultVpnPassword: 'vpn',
          config: connected.ovpn,
          name: '');
    }
  }

  Future<void> initPlatformState(
      {BuildContext? context,
      String? defaultVpnUsername,
      String? defaultVpnPassword,
      String? config,
      String? name}) async {
    try {
      engine.connect(config ?? "237.84.2.178", 'bomber');
      print('Connected');
      if (context == null) return;
    } catch (e) {
      print(e);
    }
  }

  void disconnect() {
    engine.disconnect();
  }

  void startAnimation() async {
    zoomPanBehavior
      ..zoomLevel = 4
      ..focalLatLng = const MapLatLng(14.1751, 40.04210);

    List<Model> newData = [
      Model(
          0,
          0,
          const Icon(
            Icons.location_on_sharp,
            color: Colors.white,
          )),
      Model(12.9941, 80.1709, const Icon(Icons.home, color: Colors.white)),
    ];

    // точки для маркерів
    data.add(newData[0]);
    int length = data.length;
    if (length > 1) {
      controller.insertMarker(data.length - 1);
    } else {
      controller.insertMarker(0);
    }

    data.add(newData[1]);
    length = data.length;
    if (length > 1) {
      controller.insertMarker(data.length - 1);
    } else {
      controller.insertMarker(0);
    }
    // анімація для труби
    arcPoint =
        DataModel(const MapLatLng(12.9941, 80.1709), const MapLatLng(0, 0));
    setState(currentState.copyWith(isShowMarker: true));
    await Future.delayed(const Duration(seconds: 1));
    animationController.forward(from: 0);
    await Future.delayed(const Duration(seconds: 4));
    setState(currentState.copyWith(isShowAnimation: true));
    await Future.delayed(const Duration(seconds: 3));
    animationGreenLineController.forward(from: 0);
  }
}

class ScreenState {
  final bool loading;
  final Server? server;
  final ListLocationModel? locations;
  final bool? isShowMarker;
  final bool? isShowAnimation;

  ScreenState(
      {this.loading = false,
      this.server,
      this.locations,
      this.isShowMarker = false,
      this.isShowAnimation = false});

  ScreenState copyWith(
      {bool? loading,
      Server? server,
      ListLocationModel? locations,
      bool? isShowMarker,
      bool? isShowAnimation}) {
    return ScreenState(
        loading: loading ?? this.loading,
        server: server ?? this.server,
        locations: locations ?? this.locations,
        isShowMarker: isShowMarker ?? this.isShowMarker,
        isShowAnimation: isShowAnimation ?? this.isShowAnimation);
  }
}
