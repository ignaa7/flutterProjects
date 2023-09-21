import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayersNamesNotifier
    extends StateNotifier<Map<String, Map<String, dynamic>>> {
  PlayersNamesNotifier() : super({});

  void setPlayer(String player, String name) {
    state = {
      ...state,
      player: {
        'name': name,
        'score': 0,
      },
    };
  }

  void addPoint(String player) {
    final players = state;

    players[player]!['score']++;
    state = players;
  }
}

final playersNamesProvider =
    StateNotifierProvider<PlayersNamesNotifier, Map<String, dynamic>>(
        (ref) => PlayersNamesNotifier());
