import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_github_actions_playground/src/counter.dart';

@immutable
class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
        ),
        floatingActionButton: const _FAB(),
        body: const SafeArea(
          child: Center(
            child: _CurrentData(),
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) => super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              'Home StatelessWidget',
            ),
          ),
      );
}

@immutable
class _CurrentData extends StatelessWidget {
  const _CurrentData({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => StreamBuilder<int>(
        initialData: Counter.of(context).currentValue,
        stream: Counter.of(context).values,
        builder: (context, snapshot) => Text(
          '${snapshot?.data ?? 0}',
          textScaleFactor: 2,
          textAlign: TextAlign.center,
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) => super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              '_CurrentData StatelessWidget',
            ),
          ),
      );
}

@immutable
class _FAB extends StatelessWidget {
  const _FAB({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: () => Counter.of(context).increment(),
        child: const Icon(Icons.add),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) => super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              '_FAB StatelessWidget',
            ),
          ),
      );
}
