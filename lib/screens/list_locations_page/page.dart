import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/api/locations/dto.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/custom_stream_builder.dart';
import 'package:vpn/utils/spaces.dart';
import 'package:vpn/widgets/custom_card.dart';
import 'package:vpn/widgets/custom_indicator.dart';
import 'package:vpn/widgets/custom_scaffold.dart';
import 'bloc.dart';

@RoutePage()
class ListLocationsPage extends StatefulWidget {
  final ListLocationModel? locations;

  const ListLocationsPage({super.key, this.locations});

  @override
  State<ListLocationsPage> createState() => _ListLocationsPageState();
}

class _ListLocationsPageState extends State<ListLocationsPage> {
  late ListLocationsBloc bloc = ListLocationsBloc();

  @override
  void initState() {
    bloc.init(context, widget.locations);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: bloc,
        builder: (context, ScreenState state) {
          return CustomScaffold(
              showGoPro: 'yellow',
              body: !(state.loading)
                  ? const CustomIndicator()
                  : ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        Text('Freemium locations:', style: BS.bold12),
                        Space.h8,
                        Column(
                          children: [
                            for (final Server free
                                in state.locations?.freeServers ?? [])
                              CustomCardLocation(
                                onTap: () => bloc.selectServer(context, free),
                                image: free.flag,
                                title: '${free.code}',
                              ),
                          ],
                        ),
                        Space.h16,
                        Row(
                          children: [
                            Assets.icons.premium.svg(
                              width: 24,
                              height: 24,
                            ),
                            Space.w8,
                            Text('Premium locations:', style: BS.bold12),
                          ],
                        ),
                        Space.h8,
                        Column(
                          children: [
                            for (final Server premium
                                in state.locations?.premiumServers ?? [])
                              CustomCardLocation(
                                onTap: () =>
                                    bloc.selectServer(context, premium),
                                image: premium.flag,
                                title: premium.code,
                              ),
                          ],
                        ),
                      ],
                    ));
        });
  }
}
