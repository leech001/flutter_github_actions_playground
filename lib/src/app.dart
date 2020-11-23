import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_github_actions_playground/src/counter.dart';
import 'package:flutter_github_actions_playground/src/home.dart';
import 'package:flutter_github_actions_playground/src/splash.dart';

@immutable
class App extends StatelessWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'APP',
        home: Counter(
          splash: Splash(),
          child: Home(),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) => super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              'App',
            ),
          ),
      );
}
