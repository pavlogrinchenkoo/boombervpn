import 'dart:convert';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vpn/api/cache.dart' as a;
import 'package:vpn/api/locations/dto.dart';
import 'package:vpn/api/locations/request.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/main.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/screens/home_page/page.dart';
import 'package:vpn/utils/bloc_base.dart';
import 'package:vpn/utils/math.dart';

import 'widgets/map_animation.dart';
import 'widgets/pulsation_dot.dart';

class HomeBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  LocationsApi locationsApi = LocationsApi();
  a.Cache cache = a.Cache();
  late AnimationController buttonController;

  HomeBloc() {
    setState(ScreenState());
  }

  void initController(AnimationController animationController) {
    buttonController = animationController;
  }

  void init(BuildContext context) async {
    try {
      final getLocation = await cache.getLocation();
      final locations = await locationsApi.getListLocation();
      final server = await cache.getServer();
      final isConnected = await engine.isConnected();
      if (server != null) {
        selectServer(server);
      } else {
        selectServer(locations.freeServers?.first ?? Server());
      }
      await initRoot();

      setState(currentState.copyWith(
          locations: locations,
          loading: true,
          latLng: getLocation,
          isConnected: isConnected));
      if (isConnected) {
        await Future.delayed(const Duration(seconds: 2));
        startAnimation(server ?? locations.freeServers?.first ?? Server());
      }
      final connectVpn = await cache.getConnectVPN();
      if (connectVpn && server != null && isConnected == false) {
        if (context.mounted) {
          connected(context, server);
        }
      }
    } catch (e) {
      if (context.mounted) {
        cache.removeUser();
        context.router.replaceAll([const AuthRoute()]);
      }
    }
  }

  void initMap() async {
    await Future.delayed(const Duration(seconds: 2));
    final getLocation = currentState.latLng!;
    final model = Model(getLocation.latitude ?? 1, getLocation.longitude ?? 1,
        const Animation2());
    data.add(model);
    data.remove(data[0]);
    controller.clearMarkers();
    controller.insertMarker(0);
  }

  void selectServer(Server server) async {
    setState(currentState.copyWith(server: server, loading: true));
    cache.saveServer(server);
  }

  void goListLocations(BuildContext context) {
    context.router.push(ListLocationsRoute(locations: currentState.locations));
  }

  void connected(BuildContext context, Server server) async {
    try {
      homeBloc.buttonController.repeat();
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
          config: connected.ovpn,
        );
        startAnimation(server);
      }
      final getIp = await locationsApi.getIp();
      setState(currentState.copyWith(isConnected: true, ip: getIp));
    } on Exception catch (e) {
      buttonController.reset();
      final notification = await cache.getShowNotification();
      if (notification) {
        if (context.mounted) showNotification(context);
      }
    }
  }

  Future<void> initPlatformState(
      {BuildContext? context, String? config}) async {
    try {
      String base64EncodedCertificate = config ?? '';
      List<int> bytes = base64.decode(base64EncodedCertificate);
      String certificate = utf8.decode(bytes);
      engine.connect(certificate, 'bomber');
      print('Connected');
      if (context == null) return;
    } catch (e) {
      print(e);
    }
  }

  void disconnect() async {
    final getLocation = await cache.getLocation();
    engine.disconnect();
    setState(currentState.copyWith(
        isConnected: false, isShowAnimation: false, isShowMarker: false));
    final model = Model(getLocation.latitude ?? 1, getLocation.longitude ?? 1,
        const Animation2());
    controller.removeMarkerAt(1);
    data.removeAt(1);
    data.insert(0, model);
    controller.clearMarkers();
    controller.insertMarker(0);
  }

  void setMarker(MapLatLng latLng) async {
    await Future.delayed(const Duration(seconds: 3));
    final model = Model(
        latLng.latitude ?? 1,
        latLng.longitude ?? 1,
        Center(
          child: Assets.icons.burrow001.svg(
            width: 20,
            height: 20,
          ),
        ));
    data.remove(data[0]);
    data.insert(0, model);
    controller.removeMarkerAt(0);
    controller.insertMarker(0);
  }

  void startAnimation(Server server) async {
    final getLocation = await cache.getLocation();
    final model = Model(getLocation.latitude ?? 1, getLocation.longitude ?? 1,
        const Animation3());
    data.clear();
    data.add(model);
    controller.clearMarkers();
    controller.insertMarker(0);
    // setMarker(getLocation);
    zoomPanBehavior
      ..zoomLevel = calculateZoomLevel(calculateDistance(
        getLocation.latitude,
        getLocation.longitude,
        server.latitude ?? 1,
        server.longitude ?? 1,
      ))
      ..focalLatLng = midPoint(server.latitude ?? 1, server.longitude ?? 1,
          getLocation.latitude, getLocation.longitude);
    // анімація для труби
    await Future.delayed(const Duration(seconds: 1));
    arcPoint = DataModel(MapLatLng(getLocation.latitude, getLocation.longitude),
        MapLatLng(server.latitude ?? 1, server.longitude ?? 0));
    setState(currentState.copyWith(isShowMarker: true));
    animationController.forward(from: 0);
    await Future.delayed(const Duration(seconds: 1));
    final newMarker =
        Model(server.latitude ?? 1, server.longitude ?? 1, const Animation1());
    data.insert(1, newMarker);
    controller.insertMarker(1);
    setNewMarker(MapLatLng(server.latitude ?? 1, server.longitude ?? 0));
    await Future.delayed(const Duration(seconds: 1));
    buttonController.reset();
  }

  void setNewMarker(MapLatLng latLng) async {
    await Future.delayed(const Duration(seconds: 2));
    final model =
        Model(latLng.latitude ?? 1, latLng.longitude ?? 1, const Animation2());
    data.remove(data[1]);
    data.insert(1, model);
    controller.removeMarkerAt(1);
    controller.insertMarker(1);
  }

  Future<void> showNotification(BuildContext context) async {
    final s = S.of(context); // for localization.
    try {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('your channel id', 'your channel name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker');
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
          0, 'Bomber VPN', s.server_not_connected, notificationDetails,
          payload: 'item x');
    } on Exception catch (e) {
      print(e);
    }
  }

  MapLatLng midPoint(double lat1, double lon1, double lat2, double lon2) {
    double dLon = math.pi / 180 * (lon2 - lon1);

    lat1 = math.pi / 180 * lat1;
    lat2 = math.pi / 180 * lat2;
    lon1 = math.pi / 180 * lon1;

    double Bx = math.cos(lat2) * math.cos(dLon);
    double By = math.cos(lat2) * math.sin(dLon);
    double lat3 = math.atan2(math.sin(lat1) + math.sin(lat2),
        math.sqrt((math.cos(lat1) + Bx) * (math.cos(lat1) + Bx) + By * By));
    double lon3 = lon1 + math.atan2(By, math.cos(lat1) + Bx);

    print('${lat3 * 180 / math.pi} ${lon3 * 180 / math.pi}');
    return MapLatLng(lat3 * 180 / math.pi, lon3 * 180 / math.pi);
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371.0;

    double dLat = radians(lat2 - lat1);
    double dLon = radians(lon2 - lon1);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(radians(lat1)) *
            math.cos(radians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    print(earthRadius * c);
    return earthRadius * c; // Відстань у кілометрах
  }

  // Функція для визначення рівня масштабування на основі відстані
  double calculateZoomLevel(double distance) {
    const double minZoom = 2;
    const double maxZoom = 15;
    double zoomDistance = distance < 5000
        ? 270
        : distance > 10000
            ? 400
            : 300;
    int intervals = (distance / zoomDistance).floor();

    double zoomCorrection = intervals.toDouble() / 2;

    double baseZoom = maxZoom - zoomCorrection;

    double zoomLevel = math.max(minZoom, math.min(maxZoom, baseZoom));
    print(zoomLevel);
    return zoomLevel - 1;
  }

  Future<void> initRoot() async {
    const String svgString =
        '''<svg id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 811.16 58.76">
    <defs>
        <style>
            .cls-2{fill:#593318}.cls-3{fill:#9c673f}.cls-4{fill:#613c23}.cls-5{fill:#6a371a}
        </style>
    </defs>
    <path style="fill:#3a1e0c" d="m800.27 10.93-4.37-1.11-8-1.08-7.99-.21-8-6.79-8 3.97-8 5.22-8-8.28-7.99 6.24-8 3.46-7.99-3.12-8 4.81-8-6.61-8-3.78-7.99 9.54-8-11.12-7.99 3.72-8-5.79-7.99 13.93-8-2.79-7.99-10.12-8 5.54-8 3.15-8-8.6-8 7.77-7.99-1.04-8-1.66-7.99-3.01-8 5.67-8 6.23-8-5.3-8 .02L548 2.47l-8 8.35-8-2.15-7.99-1.47-8 .56-8 3.69-8-3.35-8-1.22-8 4.94h-8l-7.99-9.68-8 2.45-8.01 3.93-7.99-7.78-8 11.97-8-1.26-8 4.03-8-11.7-8 10.5-8-8.75-8-.49-8 .72-8-3.11-8 9.81-8-.88-8 2.1-8-3.2-8-6.87-8 10.15-8-13.56-8 7.68-8.01 4.41-8 1.87-8-9.5-8-1.96-8 9.74-8-1.56-8-7.22L244 7.03l-8 1.34-8 3.08-8-7.38-8 4.17-8.01-.14-7.99-.35-8-5.01-8 8.54-8-2.65-8 5.6-8-4.7-8.01-6.96-8-.77-8 6.35-8-6.06-8.01 12-8-12.92-8 .95-8.01 6.85-8 1.15-8.01-7.71-8 5.2-8.01 5.85-8 1.63-8-9.32-8.01 2.09-8.01-5.13-8 10.41-8.02-.13L.31 4.25 11.1 16.23l-8.95 8.66 9.63 8.66L0 42.21l6.85 5.93 5.05-4.16 8 1 8 3.14 8 3.12 8-6.43 8 9.57 7.99-1.5 8-1.31 7.99-7.48 8 5.36 8 7.82 8-9.04 7.99-1.18 8 11.55 7.99-11.78 8 9.16 7.99-10.82 8 12.57 7.99-2.13 8-7.8 8-2.75 8 12.47 8-13.41 7.99 9.44 8-3.89 7.99 2.57 8 .96 7.99-4.47 8 4.62 8 .11 8-1.89 8-6.51 8 11.16 7.99.11 8-1.84 8-4.23 8-2.82 8 2.26 8-6.75 7.99 9.54 8 6.28 8-12.97 8 7.2 8-3.9 8-3.07 8 2.85 8-4.19 8 6.32 8 .8 8-1.55 7.99-2.23 8 2.34 8.01 4.8 8-5.72 8 2.15 8-8.7 8 14.62 8-12.9 8 6.65 8-6.78 8 5.98 8 5.66 8-11.65 8 5 8-2.51 8-.48 8.01 5.1 8-5.43 8-.87 8 11.01 8-10.41 8 7.15 8.01-9.69 8 8.3 8-2 8 1.62 8 1.63 8 5.58 8-4.69 8-4.97 8 6.25 8-7.62 8 3.19 8.01 5.22 8-1.16 8-5.96 8.01-3.49 8 1.63 8 .17 8.01 9.25 8-9.39 8.01 10.12 8-2.65 8.01 2.76 8-7.03 8.01 6 8-10.28 8.01 3.22 8.01 5.67 8.76-3.15 6.51-9.35-11.92-8.65 8.47-8.66-4.56-8.47-2.88-5.5z"/>
    <path style="fill:#593318" class="cls-2" d="M464.58 499.34c6.6 2.22 14 6.5 14.9 13.76a99.13 99.13 0 0 1-75.66 5.1c-2-.66-4.29-1.77-4.68-3.94s1.42-4 3.11-5.23c19.41-14.35 38.92-17.57 62.33-9.69Z" transform="translate(-143.1 -473.28)"/>
    <path style="fill:#9c673f" class="cls-3" d="M468.28 504.28c-17.71-7.52-46.87-9.8-61.3 4.23-5.31 5.17 76.15 2.06 61.3-4.23ZM778.68 501.37c4.31 1.45 9.12 4.25 9.73 9a64.75 64.75 0 0 1-49.41 3.32c-1.3-.44-2.8-1.16-3.05-2.57s.93-2.61 2-3.42c12.69-9.38 25.43-11.48 40.73-6.33Z" transform="translate(-143.1 -473.28)"/>
    <path style="fill:#613c23" class="cls-4" d="M781.1 504.59c-11.57-4.9-30.62-6.4-40.05 2.77-3.47 3.38 49.74 1.34 40.05-2.77Z" transform="translate(-143.1 -473.28)"/>
    <path style="fill:#593318" class="cls-2" d="M543.52 500.38c4.94.82 10.66 2.93 12.17 7.64-15 10-34.35 14-53.05 10.9-1.49-.25-3.25-.75-3.78-2.15s.54-2.79 1.59-3.78c12.09-11.44 25.55-15.51 43.07-12.61Z" transform="translate(-143.1 -473.28)"/>
    <path style="fill:#613c23" class="cls-4" d="M546.72 503.29c-13.43-3.23-34.38-1.85-43 8.89-3.13 3.95 54.28-6.18 43-8.89Z" transform="translate(-143.1 -473.28)"/>
    <path style="fill:#593318" class="cls-2" d="M346.05 490.61a50 50 0 0 1 30.69.8c-5 6.68-10.21 13.35-16.62 18.92s-14.19 10-22.82 11.5c-4.33.74-23.95.59-23.26-6.52a5.94 5.94 0 0 1 1.44-2.86c7.23-9.33 18.69-18.29 30.57-21.84Z" transform="translate(-143.1 -473.28)"/>
    <path style="fill:#613c23" class="cls-4" d="M320.31 512.44c-3.79 0 13.53-22.93 47.29-21.43 9.14.4-32.3 21.54-47.29 21.43Z" transform="translate(-143.1 -473.28)"/>
    <path style="fill:#9c673f" class="cls-3" d="M680.19 496.11s14.82 7.41 13.89 13.43-15.74 8.33-27.32 4.16 0-25.46 13.43-17.59ZM401.4 485.72s14.82 7.41 13.89 13.43-15.74 8.33-27.32 4.16.03-25.46 13.43-17.59ZM516 485.41s10.85 6.1 10.17 11.06-11.53 6.86-20 3.43.01-20.96 9.83-14.49ZM912.22 499.57S927 507 926.11 513s-15.74 8.34-27.32 4.17.01-25.47 13.43-17.6ZM607.33 495.8s7.66 6.1 7.18 11.05-8.13 6.87-14.12 3.44.01-20.97 6.94-14.49Z" transform="translate(-143.1 -473.28)"/>
    <path style="fill:#6a371a" class="cls-5" d="M628.81 495.38s5.4 4.31 5.06 7.8-5.73 4.84-10 2.42.05-14.79 4.94-10.22Z" transform="translate(-143.1 -473.28)"/>
    <path style="fill:#9c673f" class="cls-3" d="M361.45 504.46s7.65 6.1 7.17 11.05-8.13 6.86-14.11 3.43 0-20.94 6.94-14.48ZM737.2 487.14s7.66 6.11 7.18 11.06-8.13 6.86-14.12 3.43.01-20.96 6.94-14.49ZM848.45 493.06s10.83 7.79 10.15 14.1-11.5 8.75-20 4.38.04-26.74 9.85-18.48ZM878.22 483.7s6.85 4.8 6.42 8.68-7.28 5.39-12.64 2.69 0-16.45 6.22-11.37ZM285.75 511s-5.77 10.85-10.22 10-5.89-11.83-2.59-20.35 18.9.54 12.81 10.35ZM184.66 491s15.27-1 17.33 4.25-8.68 14-19.86 16S170.29 491 184.66 491Z" transform="translate(-143.1 -473.28)"/>
    <path style="fill:#6a371a" class="cls-5" d="M556.91 500.23s-2.07 19.95 8.73 17.86 17.87-7.9 10-17.45-17.48-13.29-18.73-.41ZM588 484.51s-7.63 3.6-4.53 7 6.75 4.71 8.46-.21.99-9.15-3.93-6.79Z" transform="translate(-143.1 -473.28)"/>
    <path style="fill:#9c673f" class="cls-3" d="M252.08 496.63s-7.63 3.6-4.53 7 6.74 4.72 8.46-.21.99-9.15-3.93-6.79Z" transform="translate(-143.1 -473.28)"/>
    <path style="fill:#6a371a" class="cls-5" d="M711 494.9s-7.64 3.6-4.53 7 6.74 4.71 8.46-.21.93-9.15-3.93-6.79ZM225.72 492.55s-12.7 6.25-7.4 11.92 11.43 7.72 14.18-.59 1.39-15.42-6.78-11.33ZM300.18 499.47s-12.7 6.25-7.4 11.92 11.43 7.72 14.18-.59 1.39-15.42-6.78-11.33ZM487.19 492.55s-12.7 6.25-7.4 11.92 11.43 7.72 14.18-.59 1.39-15.42-6.78-11.33ZM805.81 496s-12.7 6.25-7.41 11.92 11.44 7.72 14.18-.59 1.42-15.41-6.77-11.33ZM854 501.78s-8.32 4.09-4.85 7.8 7.48 5.05 9.28-.39.93-10.09-4.43-7.41ZM897.31 507s-8.32 4.09-4.85 7.81 7.48 5.05 9.28-.39.91-10.13-4.43-7.42ZM931.94 489.66s-8.32 4.09-4.85 7.8 7.49 5.05 9.28-.39.92-10.07-4.43-7.41ZM658.91 497.13c4.11-.69 7.3 3 5.31 9.62s-15.07 8.84-15.93 1 6.52-9.93 10.62-10.62Z" transform="translate(-143.1 -473.28)"/>
</svg>
''';
    final PictureInfo pictureInfo =
        await vg.loadPicture(const SvgStringLoader(svgString), null);
    setState(currentState.copyWith(pictureInfo: pictureInfo));
  }
}

class ScreenState {
  final bool loading;
  final Server? server;
  final ListLocationModel? locations;
  final bool? isShowMarker;
  final bool? isShowAnimation;
  final bool isConnected;
  final MapLatLng? latLng;
  final String ip;
  final PictureInfo? pictureInfo;

  ScreenState(
      {this.loading = false,
      this.server,
      this.locations,
      this.isShowMarker = false,
      this.isShowAnimation = false,
      this.isConnected = false,
      this.latLng,
      this.ip = '',
      this.pictureInfo});

  ScreenState copyWith(
      {bool? loading,
      Server? server,
      ListLocationModel? locations,
      bool? isShowMarker,
      bool? isShowAnimation,
      bool? isConnected,
      MapLatLng? latLng,
      String? ip,
      PictureInfo? pictureInfo}) {
    return ScreenState(
        loading: loading ?? this.loading,
        server: server ?? this.server,
        locations: locations ?? this.locations,
        isShowMarker: isShowMarker ?? this.isShowMarker,
        isShowAnimation: isShowAnimation ?? this.isShowAnimation,
        isConnected: isConnected ?? this.isConnected,
        latLng: latLng ?? this.latLng,
        ip: ip ?? this.ip,
        pictureInfo: pictureInfo ?? this.pictureInfo);
  }
}
