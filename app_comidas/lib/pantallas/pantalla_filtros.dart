import 'package:app_comidas/providers/filters_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PantallaFiltros extends ConsumerWidget {
  const PantallaFiltros({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: Column(children: [
        SwitchListTile(
          value: activeFilters[Filter.glutenFree]!,
          onChanged: (elegido) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.glutenFree, elegido);
          },
          title: Text(
            'Gluten-free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            'Only include gluten-free meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: activeFilters[Filter.lactoseFree]!,
          onChanged: (elegido) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.lactoseFree, elegido);
          },
          title: Text(
            'Lactose-free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            'Only include lactose-free meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: activeFilters[Filter.vegetarian]!,
          onChanged: (elegido) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegetarian, elegido);
          },
          title: Text(
            'Vegetarian',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            'Only include vegetarian meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: activeFilters[Filter.vegan]!,
          onChanged: (elegido) {
            ref.read(filtersProvider.notifier).setFilter(Filter.vegan, elegido);
          },
          title: Text(
            'Vegan',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            'Only include vegan meals.',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
      ]),
    );
  }
}
