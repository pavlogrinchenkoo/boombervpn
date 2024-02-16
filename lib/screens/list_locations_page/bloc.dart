import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/api/cache.dart';
import 'package:vpn/api/locations/dto.dart';
import 'package:vpn/api/locations/request.dart';
import 'package:vpn/routers/routes.dart';
import 'package:vpn/screens/home_page/page.dart';
import 'package:vpn/utils/bloc_base.dart';

class ListLocationsBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;

  LocationsApi locationsApi = LocationsApi();
  Cache cache = Cache();

  ListLocationsBloc() {
    setState(ScreenState());
  }

  void init(BuildContext context, ListLocationModel? locations) async {
    setState(ScreenState(locations: locations, loading: true));
  }

  void selectServer(BuildContext context, Server server) async {
    homeBloc.selectServer(server);
    if (context.mounted) {
      context.router.pop();
    }
  }
}

class ScreenState {
  final bool loading;
  final ListLocationModel? locations;

  ScreenState({this.loading = false, this.locations});

  ScreenState copyWith({bool? loading, ListLocationModel? locations}) {
    return ScreenState(
        loading: loading ?? this.loading,
        locations: locations ?? this.locations);
  }
}
