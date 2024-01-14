import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersProviderNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersProviderNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarian: false,
          Filters.vegan: false,
        });
  void setFilters(Map<Filters, bool> value) {
    state = value;
  }

  void setFilter(Filters filter, bool value) {
    state = {
      ...state,
      filter: value,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersProviderNotifier, Map<Filters, bool>>(
        (ref) => FiltersProviderNotifier());
