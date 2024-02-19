import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_app/screens/auth_screen.dart';

class CurrentScreenNotifier extends StateNotifier<Widget> {
  CurrentScreenNotifier() : super(const AuthScreen());

  void setCurrentScreen(Widget screen) {
    state = screen;
  }
}

final currentScreenProvider =
    StateNotifierProvider<CurrentScreenNotifier, Widget>(
        (ref) => CurrentScreenNotifier());
