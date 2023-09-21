import 'dart:io';

import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final TextEditingController _placeNameController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  @override
  void dispose() {
    _placeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(children: [
            TextField(
              controller: _placeNameController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
                counterText: ' ',
              ),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            ImageInput(onPickImage: (image) => _selectedImage = image),
            const SizedBox(height: 20),
            LocationInput(
                onSelectLocation: (location) => _selectedLocation = location),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                String title = _placeNameController.text;
                if (title.isNotEmpty &&
                    _selectedImage != null &&
                    _selectedLocation != null) {
                  ref.read(favoritePlacesProvider.notifier).changeFavorite(
                        Place(
                          title: title,
                          image: _selectedImage!,
                          location: _selectedLocation!,
                        ),
                      );
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ]),
        ),
      ),
    );
  }
}
