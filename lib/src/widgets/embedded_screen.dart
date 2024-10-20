import 'package:flutter/material.dart';

class EmbeddedScreen extends StatefulWidget {
  final Widget Function() builder;

  const EmbeddedScreen({required this.builder});

  @override
  State<StatefulWidget> createState() => _EmbeddedScreenState();
}

class _EmbeddedScreenState extends State<EmbeddedScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }
}
