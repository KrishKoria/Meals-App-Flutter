import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Models/meal.dart';

class FavouritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavouritesMealsNotifier() : super([]);
  bool toggleFavouriteStatus(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouritesMealsNotifier, List<Meal>>(
        (ref) => FavouritesMealsNotifier());
