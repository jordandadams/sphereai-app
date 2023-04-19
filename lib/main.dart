import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'config/theme.dart';
import 'states/theme_mode_state.dart';
import 'ui/screens/auth_screen.dart';
import 'ui/screens/skeleton_screen.dart';

void main() async {
  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  final Directory tmpDir = await getTemporaryDirectory();
  await Hive.initFlutter(tmpDir.toString());
  await Hive.openBox('prefs');

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeModeState currentTheme = ref.watch(themeProvider);

    return MaterialApp(
      /// Use a hardcoded string for the title.
      title: 'Flutter Production Boilerplate',

      /// Theme stuff
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: currentTheme.themeMode,

      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
    );
  }
}