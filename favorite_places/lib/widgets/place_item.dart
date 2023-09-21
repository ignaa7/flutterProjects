import 'package:flutter/material.dart';

import '../model/place.dart';

class PlaceItem extends StatelessWidget {
  final Place place;
  final Function showPlaceDetailsScreen;

  const PlaceItem({
    super.key,
    required this.place,
    required this.showPlaceDetailsScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: () => showPlaceDetailsScreen(place),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(place.image),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 5),
                Text(
                  place.location.address,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
