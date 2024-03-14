import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vpn/generated/assets.gen.dart';
import 'package:vpn/generated/l10n.dart';
import 'package:vpn/screens/go_pro_page/widgets/phone_page.dart';
import 'package:vpn/screens/go_pro_page/widgets/tablet_page.dart';
import 'package:vpn/style.dart';
import 'package:vpn/utils/custom_stream_builder.dart';
import 'package:vpn/utils/spaces.dart';
import 'bloc.dart';

@RoutePage()
class GoProPage extends StatefulWidget {
  const GoProPage({super.key});

  @override
  State<GoProPage> createState() => _GoProPageState();
}

class _GoProPageState extends State<GoProPage> {
  final GoProBloc bloc = GoProBloc();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return CustomStreamBuilder(
        bloc: bloc,
        builder: (BuildContext context, state) {
          return width < 600 ? PhonePage(bloc: bloc) : TabletPage(bloc: bloc);
        });
  }
}
