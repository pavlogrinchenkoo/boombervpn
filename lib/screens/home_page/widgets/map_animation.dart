import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vpn/screens/home_page/page.dart';
import 'package:vpn/style.dart';

late DataModel arcPoint;
late List<MapLatLng> markerData;
late AnimationController animationController;
late AnimationController animationGreenLineController;
late Animation<double> animation;
late Animation<double> animationGreenLine;
late MapShapeSource dataSource;
late MapZoomPanBehavior zoomPanBehavior;
late MapShapeLayerController controller;
late List<Model> data;

class MapAnimation extends StatefulWidget {
  final bool isShowMarker;
  final bool isShowAnimation;

  const MapAnimation({
    super.key,
    required this.isShowMarker,
    required this.isShowAnimation,
  });

  @override
  State<MapAnimation> createState() => _MapAnimationState();
}

class _MapAnimationState extends State<MapAnimation>
    with TickerProviderStateMixin {
  Timer? timer;
  double longitude = 0;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    controller = MapShapeLayerController();
    data = <Model>[];
    zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: const MapLatLng(40.1751, 25),
      zoomLevel: 3.8,
    );
    dataSource = const MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'continent',
    );

    animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    animationGreenLineController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationGreenLine = CurvedAnimation(
      parent: animationGreenLineController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SfMaps(
      layers: [
        MapShapeLayer(
          controller: controller,
          color: BC.darkGrey,
          strokeColor: BC.grey,
          strokeWidth: 0.5,
          source: dataSource,
          zoomPanBehavior: zoomPanBehavior,
          initialMarkersCount: data.length,
          markerBuilder: (BuildContext context, int index) {
            return MapMarker(
              latitude: data[index].latitude,
              longitude: data[index].longitude,
              iconType: MapIconType.circle,
              iconColor: Colors.black,
              iconStrokeWidth: 10,
              iconStrokeColor: Colors.black,
              size: const Size(10, 10),
              child: data[index].icon,
            );
          },
          sublayers: widget.isShowMarker
              ? [
                  MapArcLayer(
                    arcs: <MapArc>{
                      MapArc(
                        from: arcPoint.from,
                        to: arcPoint.to,
                        color: widget.isShowAnimation
                            ? BC.green.withOpacity(0.5)
                            : BC.blue.withOpacity(0.5),
                        width: 10,
                        heightFactor: 0,
                        controlPointFactor: 0.5,
                      ),
                      MapArc(
                        from: arcPoint.from,
                        to: arcPoint.to,
                        color: widget.isShowAnimation ? BC.green : BC.blue,
                        width: 11,
                        heightFactor: 0,
                        controlPointFactor: 0.5,
                        dashArray: [2, 20],
                      ),
                    },
                    animation: animation,
                  ),
                ]
              : [],
        ),
      ],
    );
  }
}

class DataModel {
  DataModel(this.from, this.to);

  MapLatLng from;
  MapLatLng to;
}

class Model {
  Model(this.latitude, this.longitude, this.icon);

  final double latitude;
  final double longitude;
  Icon icon;
}
