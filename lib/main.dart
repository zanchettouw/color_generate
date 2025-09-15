import 'package:color_generate/app.dart';
import 'package:color_generate/core/di/injection_container.dart';
import 'package:flutter/material.dart';

/// Entry point of the application.
///
/// Initializes dependencies using the service locator pattern and
/// launches the application with proper dependency injection setup.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const App());
}
