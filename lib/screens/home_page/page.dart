import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:openvpn_sf_flutter/openvpn_flutter.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vpn/api/locations/dto.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/screens/home_page/widgets/map_animation.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/custom_stream_builder.dart';
import 'package:vpn/utils/spaces.dart';
import 'package:vpn/widgets/custom_card.dart';
import 'package:vpn/widgets/custom_indicator.dart';
import 'package:vpn/widgets/custom_scaffold.dart';

import 'bloc.dart';

final HomeBloc homeBloc = HomeBloc();
late OpenVPN engine;

bool granted = false;

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VpnStatus? status;
  VPNStage? stage;

  @override
  void initState() {
    homeBloc.init(context);
    openVPN();
    super.initState();
  }

  void openVPN() async {
    engine = OpenVPN(
      onVpnStatusChanged: (data) {
        setState(() {
          status = data;
        });
      },
      onVpnStageChanged: (data, raw) {
        setState(() {
          stage = data;
        });
      },
    );

    engine.initialize(
      groupIdentifier: "group.com.laskarmedia.vpn",
      providerBundleIdentifier:
          "id.laskarmedia.openvpnFlutterExample.VPNExtension",
      localizedDescription: "VPN by Nizwar",
      lastStage: (stage) {
        setState(() {
          this.stage = stage;
        });
      },
      lastStatus: (status) {
        setState(() {
          this.status = status;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     backgroundColor: BC.white,
    //     body: CustomPaint(
    //       child: Container(
    //         height: 300.0,
    //       ),
    //       painter: CurvePainter(),
    //     ));
    return CustomStreamBuilder(
        bloc: homeBloc,
        builder: (context, ScreenState state) {
          return CustomScaffold(
            showGoPro: 'blue',
            body: !(state.loading)
                ? const CustomIndicator()
                : Stack(
                    children: [
                      Space.h16,
                      MapAnimation(
                          isShowMarker: state.isShowMarker ?? false,
                          isShowAnimation: state.isShowAnimation ?? false,
                          getLocation: state.latLng ?? const MapLatLng(1, 1),
                          pictureInfo: state.pictureInfo!),
                      Space.h16,
                      Positioned(
                        top: 24,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: CustomCard(
                            onTap: () => homeBloc.goListLocations(context),
                            title: state.server?.code,
                            image: state.server?.flag,
                            isConnected: state.isConnected,
                            ip: state.ip,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 70,
                        right: MediaQuery.of(context).size.width / 4,
                        left: MediaQuery.of(context).size.width / 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: _MainButton(
                            isStartAnimation: state.isShowAnimation ?? false,
                            isConnected: state.isConnected,
                            onTap: () {
                              if (!(state.isConnected)) {
                                homeBloc.connected(
                                  context,
                                  state.server ?? Server(),
                                );
                              } else {
                                homeBloc.disconnect();
                              }
                              // homeBloc.startAnimation();
                            },
                          ),
                        ),
                      ),
                      Space.h50,
                    ],
                  ),
          );
        });
  }
}

class _MainButton extends StatefulWidget {
  final bool isConnected;
  final bool isStartAnimation;
  final Function()? onTap;

  const _MainButton(
      {super.key,
      this.onTap,
      this.isConnected = false,
      required this.isStartAnimation});

  @override
  State<_MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<_MainButton>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    homeBloc.initController(AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 152,
          width: 152,
          decoration: BoxDecoration(
            color: BC.purple,
            shape: BoxShape.circle,
          ),
        ),
        RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(homeBloc.buttonController),
          child: AnimatedOpacity(
            duration: BDuration.d200,
            opacity: homeBloc.buttonController.isAnimating ? 1 : 0,
            child: Container(
              height: 152,
              width: 152,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [BC.purple, BC.braun],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Container(
          height: 148,
          width: 148,
          decoration: BoxDecoration(
            color: BC.darkGrey,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            onTap: () => widget.onTap?.call(),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            borderRadius: BorderRadius.circular(148),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.group1.svg(),
                Space.h16,
                Text(
                  widget.isConnected ? s.disconnect : s.connect,
                  style: BS.bold12,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Path _get1SvgPath(Size size, Path path, Point start, Point end,
    {double height = 6}) {
  List<Point> zigZagPoints = [];

  double dx = end.x.toDouble() - start.x.toDouble();
  double dy = end.y.toDouble() - start.y.toDouble();

  double length = sqrt(dx * dx + dy * dy);

  double xIncrement = dx / length;
  double yIncrement = dy / length;

  double x = start.x.toDouble();
  double y = start.y.toDouble();

  Random random = Random();

  int bumpiness = 1;

  path.moveTo(x, y);
  for (double t = 0; t <= length; t += 1.0) {
    path.lineTo(x, y);

    // Добавляем бугорок
    for (int j = 0; j < bumpiness; j++) {
      x += (random.nextDouble() - 0.5) * bumpiness;
      y += (random.nextDouble() - 0.5) * bumpiness;
      path.lineTo(x, y);
    }

    x += xIncrement;
    y += yIncrement;
  }

  return path;
  // List<Point> linePoints = [];
  // List<Point> zigZagPoints = [];
  //
  // int dx = p2.x - p1.x;
  // int dy = p2.y - p1.y;
  //
  // double steps = max(dx.abs(), dy.abs()).toDouble();
  //
  // double xIncrement = dx / steps;
  // double yIncrement = dy / steps;
  //
  // double x = p1.x.toDouble();
  // double y = p1.y.toDouble();
  //
  // Random random = Random();
  // final bumpiness = 1;
  //
  // // Добавляем начальную точку
  // path.moveTo(p1.x.toDouble(), p1.y.toDouble());
  //
  // for (int i = 0; i <= steps; i++) {
  //   x += xIncrement;
  //   y += yIncrement;
  //
  //   // Добавляем бугорок
  //   for (int j = 0; j < bumpiness; j++) {
  //     x += (random.nextDouble() - 0.5) * bumpiness;
  //     y += (random.nextDouble() - 0.5) * bumpiness;
  //     path.lineTo(x, y);
  //   }
  // }

  // Добавляем конечную точку
  // path.lineTo(p2.x.toDouble(), p2.y.toDouble());

  return path;
  // path.moveTo(sx, sy);
  // path.lineTo(sx, sy + 5);
  //
  // final stepOfY = (ey - sy) / 5;
  // double nl = 0;
  // double y = sy;
  //
  // for (double x = sx; x < ex; x += 5) {
  //   final r = doubleInRange(Random(), -5, 5);
  //   nl = stepOfY - r;
  //   y += r + nl;
  //   nl = 0;
  //   print('$x $y');
  //   path.lineTo(x, y);
  // }

  return path;
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round;

    Offset startPoint = Offset(300, 300);
    Offset endPoint = Offset(50, 50);
    int humps =
    startPoint.dx > endPoint.dx ? endPoint.dx ~/ 4 : startPoint.dx ~/ 4;

    path.moveTo(startPoint.dx, startPoint.dy);

    double dx = endPoint.dx - startPoint.dx;
    double dy = (endPoint.dy + 10) - (startPoint.dy + 10);
    double dist = sqrt(dx * dx + dy * dy);

    double humpWidth = dist / (humps * 2);
    double lastX = 0;
    double lastY = 0;

    for (int i = 1; i <= humps * 2; i++) {
      double t = i / (humps * 2);
      double x = startPoint.dx + dx * t;
      double y = (startPoint.dy+10) + dy * t;
      if (i % 2 == 0) {
        y += sin(t * pi * humps) * doubleInRange(Random(), -5, 5);
      } else {
        y -= sin(t * pi * humps) * doubleInRange(Random(), -5, 5);
      }
      path.lineTo(x, y);
      lastX = x;
      lastY = y;
    }

    path.lineTo(lastX, lastY - 15);
    path.moveTo(startPoint.dx, startPoint.dy);
    path.lineTo(startPoint.dx, startPoint.dy - 10);

    dx = endPoint.dx - startPoint.dx;
    dy = (endPoint.dy) - (startPoint.dy);
    dist = sqrt(dx * dx + dy * dy);

    for (int i = 1; i <= humps * 2; i++) {
      double t = i / (humps * 2);
      double x = startPoint.dx + dx * t;
      double y = (startPoint.dy - 5) + dy * t;
      if (i % 2 == 0) {
        y += sin(t * pi * humps) * doubleInRange(Random(), -5, 5);
      } else {
        y -= sin(t * pi * humps) * doubleInRange(Random(), -5, 5);
      }
      path.lineTo(x, y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  String toString() => '($x, $y)';
}
