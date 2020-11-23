import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

@immutable
class Splash extends StatelessWidget {
  const Splash({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Initialization'),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) => super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              'Splash StatelessWidget',
            ),
          ),
      );
}
