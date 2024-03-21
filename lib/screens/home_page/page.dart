import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openvpn_sf_flutter/openvpn_flutter.dart';
import 'package:pulsator/pulsator.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vpn/api/locations/dto.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/main.dart';
import 'package:vpn/screens/home_page/widgets/map_animation.dart';
import 'package:vpn/screens/home_page/widgets/pulsation_dot.dart';
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
          print(data);
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
                      ),
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
                            ip: state.ip ,
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

  const _MainButton({super.key, this.onTap, this.isConnected = false, required this.isStartAnimation});

  @override
  State<_MainButton> createState() => _MainButtonState();
}



class _MainButtonState extends State<_MainButton> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    homeBloc.initController(
        AnimationController(
          duration: const Duration(seconds: 1),
          vsync: this,)
    );
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
            opacity: homeBloc.buttonController.isAnimating  ? 1 : 0,
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
                  widget.isConnected ? s.disconnect : s.connect_by_ping,
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
