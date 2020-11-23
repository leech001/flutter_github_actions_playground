import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_github_actions_playground/src/app.dart';
import 'package:l/l.dart';

void main() => runZonedGuarded(
      () => runApp(const App()),
      (error, stackTrace) => l.e(error.toString()),
    );
