import 'package:boilerplate_ui/app/app.dart';
import 'package:boilerplate_ui/app/di/dependency_injection.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DI.init();
  runApp(const App());
}
