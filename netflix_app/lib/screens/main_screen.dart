import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_app/providers/current_screen_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final colorScheme =
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 156, 72, 253));

  @override
  Widget build(BuildContext context) {
    final currentScreen = ref.watch(currentScreenProvider);

    return MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color.fromARGB(255, 125, 213, 253),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorScheme.onPrimaryContainer,
          foregroundColor: colorScheme.primaryContainer,
          centerTitle: true,
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: colorScheme.onPrimaryContainer,
              ),
              titleMedium: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: colorScheme.onPrimaryContainer,
              ),
              titleSmall: TextStyle(
                fontSize: 18,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primaryContainer,
          ),
        ),
      ),
      home: currentScreen,
    );
  }
}