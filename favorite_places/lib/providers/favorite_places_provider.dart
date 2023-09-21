import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import '../model/place.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)');
    },
    version: 1,
  );
  return db;
}

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super([]);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
                latitude: row['latitude'] as double,
                longitude: row['longitude'] as double,
                address: row['address'] as String),
          ),
        )
        .toList();
    state = places;
  }

  void changeFavorite(Place place) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(place.image.path);
    var favoritePlaces = state;

    if (favoritePlaces.contains(place)) {
      favoritePlaces.remove(place);
    } else {
      final copiedImage = await place.image.copy('${appDir.path}/$filename');
      place.image = copiedImage;
      favoritePlaces.add(place);
    }

    final db = await _getDatabase();

    await db.insert('user_places', {
      'id': place.id,
      'title': place.title,
      'image': place.image,
      'latitude': place.location.latitude,
      'longitude': place.location.longitude,
      'address': place.location.address,
    });

    state = favoritePlaces;
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>(
  (ref) => FavoritePlacesNotifier(),
);
