import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late  SplashBloc bloc = SplashBloc();
  @override
  void initState() {
    bloc.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}
