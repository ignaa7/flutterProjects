import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/menu_screen.dart';

class CurrentScreenNotifier extends StateNotifier<Widget> {
  CurrentScreenNotifier() : super(const MenuScreen());

  void setCurrentScreen(Widget screen) {
    state = screen;
  }
}

final currentScreenProvider =
    StateNotifierProvider<CurrentScreenNotifier, Widget>(
        (ref) => CurrentScreenNotifier());
