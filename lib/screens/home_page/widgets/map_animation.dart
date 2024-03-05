import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vpn/api/locations/dto.dart';
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
  final MapLatLng getLocation;
  final bool isShowMarker;
  final bool isShowAnimation;

  const MapAnimation({
    super.key,
    required this.isShowMarker,
    required this.isShowAnimation,
    required this.getLocation,
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
    data = <Model>[
          Model(widget.getLocation.latitude, widget.getLocation.longitude,
              const Icon(Icons.home, color: Colors.white))

    ];
    zoomPanBehavior = MapZoomPanBehavior(
      enablePanning: false,
      enablePinching: false,
      focalLatLng: const MapLatLng(40.1751, 25),
      zoomLevel: 3.8,
    );
    dataSource = const MapShapeSource.asset(
      'assets/world_map.json',
      // shapeDataField: 'continent',

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
              size: const Size(40, 40),
              child: SizedBox(
                  width: 40,
                  height: 40,
                  child: SizedBox(
                      width: 10,
                      height: 10,
                      child: Stack(
                        children: [
                          data[index].icon,
                        ],
                      ))),
            );
          },
          sublayers: widget.isShowMarker
              ? [
                  MapArcLayer(
                    arcs: {
                      MapArc(
                        from: arcPoint.from,
                        to: arcPoint.to,
                        color: widget.isShowAnimation
                            ? BC.black.withOpacity(0.5)
                            : BC.black.withOpacity(0.5),
                        width: 10,
                        heightFactor: 0,
                        controlPointFactor: 0.5,
                      ),
                      MapArc(
                        from: arcPoint.from,
                        to: arcPoint.to,
                        color: widget.isShowAnimation ? BC.purple : BC.purple,
                        width: 10,
                        heightFactor: 0,
                        controlPointFactor: 0.5,
                        dashArray: [2, 30],
                      ),
                      MapArc(
                        from: arcPoint.from,
                        to: arcPoint.to,
                        color: Colors.transparent,
                        width: 10,
                        heightFactor: 0,
                        controlPointFactor: 0.5,
                        dashArray: [2, 30],
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
