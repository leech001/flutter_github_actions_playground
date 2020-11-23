import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class Counter extends StatefulWidget {
  final Widget child;
  final Widget splash;
  const Counter({
    @required this.child,
    @required this.splash,
    Key key,
  })  : assert(child != null, 'Field child in widget Counter must not be null'),
        assert(splash != null, 'Field splash in widget Counter must not be null'),
        super(key: key);

  static _CounterState of(BuildContext context) => _CounterScope.of(context)?.state;

  @override
  State<Counter> createState() => _CounterState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) => super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              'Counter StatefulWidget',
            ),
          ),
      );
}

class _CounterState extends State<Counter> {
  static const String _key = 'data';

  BehaviorSubject<int> _controller;
  Future<void> _initialized;
  SharedPreferences _sharedPreferences;

  int get currentValue => _controller.value ?? 0;
  Stream<int> get values => _controller.stream;

  @override
  void initState() {
    super.initState();
    _controller = BehaviorSubject<int>.seeded(0);
    final completer = Completer<void>()..complete(_initialize());
    _initialized = completer.future;
  }

  void increment() {
    final newValue = currentValue + 1;
    _sharedPreferences.setInt(_key, newValue);
    _controller.add(newValue);
  }

  Future<void> _initialize() => SharedPreferences.getInstance().then<SharedPreferences>((sharedPreferences) {
        try {
          _controller.add(sharedPreferences.getInt(_key) ?? 0);
        } on dynamic catch (_) {
          _controller.add(0);
        }
        return _sharedPreferences = sharedPreferences;
      });

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) => super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              '_CounterState State<Counter>',
            ),
          ),
      );

  @override
  Widget build(BuildContext context) => FutureBuilder<void>(
        future: _initialized,
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.done
            ? _CounterScope(
                state: this,
                child: RepaintBoundary(
                  child: widget.child,
                ),
              )
            : widget.splash,
      );
}

@immutable
class _CounterScope extends InheritedWidget {
  final _CounterState state;

  const _CounterScope({
    @required Widget child,
    @required this.state,
    Key key,
  })  : assert(child != null, 'Field child in widget _CounterScope must not be null'),
        assert(state is _CounterState, 'state must not be null'),
        super(key: key, child: child);

  /// Find _CounterScope in BuildContext
  static _CounterScope of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<_CounterScope>();

  @override
  bool updateShouldNotify(_CounterScope oldWidget) => !identical(state, oldWidget.state) || state != oldWidget.state;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) => super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              'Scope of Counter',
            ),
          )
          ..add(
            IntProperty(
              'value',
              state.currentValue,
              ifNull: 'none',
            ),
          )
          ..defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.offstage,
      );
}
