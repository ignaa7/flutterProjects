import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:favorite_places/screens/place_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/place.dart';
import '../widgets/place_item.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(favoritePlacesProvider.notifier).loadPlaces();
  }

  void _showAddPlaceScreen() async {
    await showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const AddPlaceScreen(),
    );
    setState(() {});
  }

  void _showPlaceDetailsScreen(Place place) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => PlaceDetailsScreen(place),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Place> favoritePlaces = ref.watch(favoritePlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () => _showAddPlaceScreen(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : favoritePlaces.isEmpty
                      ? Center(
                          child: Text(
                            'No places added',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      : ListView.builder(
                          itemCount: favoritePlaces.length,
                          itemBuilder: (ctx, index) => PlaceItem(
                            place: favoritePlaces[index],
                            showPlaceDetailsScreen: _showPlaceDetailsScreen,
                          ),
                        ),
        ),
      ),
    );
  }
}
