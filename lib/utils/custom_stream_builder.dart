import 'package:flutter/material.dart';

class CustomStreamBuilder<T> extends StatelessWidget {
  const CustomStreamBuilder(
      {required this.bloc, required this.builder, super.key});

  final dynamic bloc;
  final Function(BuildContext context, T data) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: bloc.currentState,
        stream: bloc.state,
        builder: (context, snapshot) => builder(context, snapshot.data as T));
  }
}

