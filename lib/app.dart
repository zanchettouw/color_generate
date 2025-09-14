import 'package:color_generate/core/di/injection_container.dart';
import 'package:color_generate/presentation/bloc/color_bloc.dart';
import 'package:color_generate/presentation/pages/color_changer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The root widget of the application.
///
/// This widget sets up:
/// - BLoC provider for state management using dependency injection
/// - Initial route to [ColorChangerPage]
class MyApp extends StatelessWidget {
  /// Creates a new [MyApp] instance.
  const MyApp({super.key});

  @override
  Widget build(BuildContext _) {
    return MaterialApp(
      title: 'Color Changer',
      home: BlocProvider(
        create: (context) => sl<ColorBloc>(),
        child: const ColorChangerPage(),
      ),
    );
  }
}
