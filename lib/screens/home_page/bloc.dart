import 'dart:convert';
import 'dart:math' as math;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vpn/api/cache.dart';
import 'package:vpn/api/locations/dto.dart';
import 'package:vpn/api/locations/request.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/main.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/screens/home_page/page.dart';
import 'package:vpn/utils/bloc_base.dart';
import 'package:vpn/utils/math.dart';
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
      final getLocation = await cache.getLocation();
      final locations = await locationsApi.getListLocation();
      final server = await cache.getServer();
      final isConnected = await engine.isConnected();
      if (server != null) {
        selectServer(server);
      } else {
        selectServer(locations.freeServers?.first ?? Server());
      }
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

  void selectServer(Server server) async {
    setState(currentState.copyWith(server: server, loading: true));
    cache.saveServer(server);
  }

  void goListLocations(BuildContext context) {
    context.router.push(ListLocationsRoute(locations: currentState.locations));
  }

  void connected(BuildContext context, Server server) async {
    try {
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

  void disconnect() {
    engine.disconnect();
    setState(currentState.copyWith(
        isConnected: false, isShowAnimation: false, isShowMarker: false));
    controller.removeMarkerAt(1);
    data.removeAt(1);
  }

  void startAnimation(Server server) async {
    final getLocation = await cache.getLocation();
    zoomPanBehavior
      ..zoomLevel = calculateZoomLevel(calculateDistance(
        getLocation.latitude,
        getLocation.longitude,
        server.latitude ?? 1,
        server.longitude ?? 1,
      ))
      ..focalLatLng = midPoint(server.latitude ?? 1, server.longitude ?? 1,
          getLocation.latitude, getLocation.longitude);

    List<Model> newData = [
      Model(getLocation.latitude, getLocation.longitude,
          const Icon(Icons.person, color: Colors.transparent)),
      Model(
          server.latitude ?? 1,
          server.longitude ?? 1,
          const Icon(
            Icons.location_on_sharp,
            color: Colors.white,
          )),
    ];

    // точки для маркерів

    int length = data.length;
    data.add(newData[1]);
    length = data.length;
    if (length > 1) {
      controller.insertMarker(length - 1);
    } else {
      controller.insertMarker(0);
    }
    // анімація для труби
    arcPoint = DataModel(MapLatLng(getLocation.latitude, getLocation.longitude),
        MapLatLng(server.latitude ?? 1, server.longitude ?? 0));
    setState(currentState.copyWith(isShowMarker: true));
    await Future.delayed(const Duration(seconds: 1));
    animationController.forward(from: 0);
    await Future.delayed(const Duration(seconds: 4));
    setState(currentState.copyWith(isShowAnimation: true));
    await Future.delayed(const Duration(seconds: 3));
    animationGreenLineController.forward(from: 0);
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

  ScreenState(
      {this.loading = false,
      this.server,
      this.locations,
      this.isShowMarker = false,
      this.isShowAnimation = false,
      this.isConnected = false,
      this.latLng,
      this.ip = ''});

  ScreenState copyWith(
      {bool? loading,
      Server? server,
      ListLocationModel? locations,
      bool? isShowMarker,
      bool? isShowAnimation,
      bool? isConnected,
      MapLatLng? latLng,
      String? ip}) {
    return ScreenState(
        loading: loading ?? this.loading,
        server: server ?? this.server,
        locations: locations ?? this.locations,
        isShowMarker: isShowMarker ?? this.isShowMarker,
        isShowAnimation: isShowAnimation ?? this.isShowAnimation,
        isConnected: isConnected ?? this.isConnected,
        latLng: latLng ?? this.latLng,
        ip: ip ?? this.ip);
  }
  }
