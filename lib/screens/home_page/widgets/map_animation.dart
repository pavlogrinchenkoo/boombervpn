import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vpn/screens/home_page/page.dart';
import 'package:vpn/style.dart';

import 'pulsation_dot.dart';

late DataModel arcPoint;
late List<MapLatLng> markerData;
late AnimationController animationController;
late AnimationController animationGreenLineController;
late Animation<double> animation;
late Animation<double> animationGreenLine;
late MapShapeSource? dataSource;
late MapZoomPanBehavior zoomPanBehavior;
late MapShapeLayerController controller;
late List<Model> data;

class MapAnimation extends StatefulWidget {
  final MapLatLng getLocation;
  final bool isShowMarker;
  final bool isShowAnimation;
  final PictureInfo pictureInfo;

  const MapAnimation({
    super.key,
    required this.isShowMarker,
    required this.isShowAnimation,
    required this.getLocation,
    required this.pictureInfo,
  });

  @override
  State<MapAnimation> createState() => _MapAnimationState();
}

class _MapAnimationState extends State<MapAnimation>
    with TickerProviderStateMixin {
  Timer? timer;
  double longitude = 0;
  late double fr;
  late double sr;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    controller = MapShapeLayerController();
    data = <Model>[
      Model(widget.getLocation.latitude, widget.getLocation.longitude,
          const Animation1())
    ];

    homeBloc.initMap();
    zoomPanBehavior = MapZoomPanBehavior(
      enablePanning: false,
      enablePinching: false,
      focalLatLng: const MapLatLng(40.1751, 25),
      zoomLevel: 3.8,
    );
    dataSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: "name",
      dataCount: dataShape.length,
      primaryValueMapper: (int index) {
        return dataShape[index].country;
      },
      shapeColorValueMapper: (int index) {
        return [
          Color(0xFF70A452),
          Color(0xFF7AAE59),
          Color(0xFF6DAA4B),
          Color(0xFF6DAA4B),
          Color(0xFF7CB254),
          Color(0xFF69A241),
          Color(0xFF6BA743),
          Color(0xFF7CB25E),
          Color(0xFF7CB25E),
          Color(0xFF67A53F),
        ][(index + 10) % 10];
      },
    );

    animationController = AnimationController(
      duration: const Duration(seconds: 1),
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
    if (dataSource == null) {
      return const SizedBox.shrink();
    } else {
      return SfMaps(
        layers: [
          MapShapeLayer(
            controller: controller,
            source: dataSource!,
            zoomPanBehavior: zoomPanBehavior,
            initialMarkersCount: data.length,
            strokeColor: BC.grey,
            strokeWidth: 0.0,
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
                            color: BC.purple,
                            width: 8,
                            heightFactor: 0,
                            root: widget.pictureInfo),
                      },
                      animation: animation,
                      fr: -2,
                      sr: -2,
                    ),
                  ]
                : [],
          ),
        ],
      );
    }
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
  Widget icon;
}

class ModelShape {
  const ModelShape(this.country);

  final String country;
}

const dataShape = <ModelShape>[
  ModelShape("Afghanistan"),
  ModelShape("Angola"),
  ModelShape("Albania"),
  ModelShape("United Arab Emirates"),
  ModelShape("Argentina"),
  ModelShape("Armenia"),
  ModelShape("Australia"),
  ModelShape("Austria"),
  ModelShape("Azerbaijan"),
  ModelShape("Burundi"),
  ModelShape("Belgium"),
  ModelShape("Benin"),
  ModelShape("Burkina Faso"),
  ModelShape("Bangladesh"),
  ModelShape("Bulgaria"),
  ModelShape("Bahamas"),
  ModelShape("Bosnia and Herz."),
  ModelShape("Belarus"),
  ModelShape("Belize"),
  ModelShape("Bolivia"),
  ModelShape("Brazil"),
  ModelShape("Brunei"),
  ModelShape("Bhutan"),
  ModelShape("Botswana"),
  ModelShape("Central African Rep."),
  ModelShape("Canada"),
  ModelShape("Switzerland"),
  ModelShape("Chile"),
  ModelShape("China"),
  ModelShape("Côte d'Ivoire"),
  ModelShape("Cameroon"),
  ModelShape("Dem. Rep. Congo"),
  ModelShape("Congo"),
  ModelShape("Colombia"),
  ModelShape("Costa Rica"),
  ModelShape("Cuba"),
  ModelShape("N. Cyprus"),
  ModelShape("Cyprus"),
  ModelShape("Czech Rep."),
  ModelShape("Germany"),
  ModelShape("Djibouti"),
  ModelShape("Denmark"),
  ModelShape("Dominican Rep."),
  ModelShape("Algeria"),
  ModelShape("Ecuador"),
  ModelShape("Egypt"),
  ModelShape("Eritrea"),
  ModelShape("Spain"),
  ModelShape("Estonia"),
  ModelShape("Ethiopia"),
  ModelShape("Finland"),
  ModelShape("Fiji"),
  ModelShape("Falkland Is."),
  ModelShape("France"),
  ModelShape("Gabon"),
  ModelShape("United Kingdom"),
  ModelShape("Georgia"),
  ModelShape("Ghana"),
  ModelShape("Guinea"),
  ModelShape("Gambia"),
  ModelShape("Guinea-Bissau"),
  ModelShape("Eq. Guinea"),
  ModelShape("Greece"),
  ModelShape("Greenland"),
  ModelShape("Guatemala"),
  ModelShape("Guyana"),
  ModelShape("Honduras"),
  ModelShape("Croatia"),
  ModelShape("Haiti"),
  ModelShape("Hungary"),
  ModelShape("Indonesia"),
  ModelShape("India"),
  ModelShape("Ireland"),
  ModelShape("Iran"),
  ModelShape("Iraq"),
  ModelShape("Iceland"),
  ModelShape("Israel"),
  ModelShape("Italy"),
  ModelShape("Jamaica"),
  ModelShape("Jordan"),
  ModelShape("Japan"),
  ModelShape("Kazakhstan"),
  ModelShape("Kenya"),
  ModelShape("Kyrgyzstan"),
  ModelShape("Cambodia"),
  ModelShape("Korea"),
  ModelShape("Kosovo"),
  ModelShape("Kuwait"),
  ModelShape("Lao PDR"),
  ModelShape("Lebanon"),
  ModelShape("Liberia"),
  ModelShape("Libya"),
  ModelShape("Sri Lanka"),
  ModelShape("Lesotho"),
  ModelShape("Lithuania"),
  ModelShape("Luxembourg"),
  ModelShape("Latvia"),
  ModelShape("Morocco"),
  ModelShape("Moldova"),
  ModelShape("Madagascar"),
  ModelShape("Mexico"),
  ModelShape("Macedonia"),
  ModelShape("Mali"),
  ModelShape("Myanmar"),
  ModelShape("Montenegro"),
  ModelShape("Mongolia"),
  ModelShape("Mozambique"),
  ModelShape("Mauritania"),
  ModelShape("Malawi"),
  ModelShape("Malaysia"),
  ModelShape("Namibia"),
  ModelShape("New Caledonia"),
  ModelShape("Niger"),
  ModelShape("Nigeria"),
  ModelShape("Nicaragua"),
  ModelShape("Netherlands"),
  ModelShape("Norway"),
  ModelShape("Nepal"),
  ModelShape("New Zealand"),
  ModelShape("Oman"),
  ModelShape("Pakistan"),
  ModelShape("Panama"),
  ModelShape("Peru"),
  ModelShape("Philippines"),
  ModelShape("Papua New Guinea"),
  ModelShape("Poland"),
  ModelShape("Puerto Rico"),
  ModelShape("Dem. Rep. Korea"),
  ModelShape("Portugal"),
  ModelShape("Paraguay"),
  ModelShape("Palestine"),
  ModelShape("Qatar"),
  ModelShape("Romania"),
  ModelShape("Russia"),
  ModelShape("Rwanda"),
  ModelShape("W. Sahara"),
  ModelShape("Saudi Arabia"),
  ModelShape("Sudan"),
  ModelShape("S. Sudan"),
  ModelShape("Senegal"),
  ModelShape("Solomon Is."),
  ModelShape("Sierra Leone"),
  ModelShape("El Salvador"),
  ModelShape("Somaliland"),
  ModelShape("Somalia"),
  ModelShape("Serbia"),
  ModelShape("Suriname"),
  ModelShape("Slovakia"),
  ModelShape("Slovenia"),
  ModelShape("Sweden"),
  ModelShape("Swaziland"),
  ModelShape("Syria"),
  ModelShape("Chad"),
  ModelShape("Togo"),
  ModelShape("Thailand"),
  ModelShape("Tajikistan"),
  ModelShape("Turkmenistan"),
  ModelShape("Timor-Leste"),
  ModelShape("Trinidad and Tobago"),
  ModelShape("Tunisia"),
  ModelShape("Turkey"),
  ModelShape("Taiwan"),
  ModelShape("Tanzania"),
  ModelShape("Uganda"),
  ModelShape("Ukraine"),
  ModelShape("Uruguay"),
  ModelShape("United States of America"),
  ModelShape("Uzbekistan"),
  ModelShape("Venezuela"),
  ModelShape("Vietnam"),
  ModelShape("Vanuatu"),
  ModelShape("Yemen"),
  ModelShape("South Africa"),
  ModelShape("Zambia"),
  ModelShape("Zimbabwe"),
];
