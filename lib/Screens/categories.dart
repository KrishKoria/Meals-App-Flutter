import 'package:flutter/material.dart';
import 'package:meals_app/Data/dummy_data.dart';
import 'package:meals_app/Models/category.dart';
import 'package:meals_app/Models/meal.dart';
import 'package:meals_app/Screens/meals.dart';
import 'package:meals_app/Widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(this.availableMeals, {super.key});
  final List<Meal> availableMeals;
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeal = availableMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          title: category.title,
          meals: filteredMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(14),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryItem(category, () => _selectCategory(context, category)),
      ],
    );
  }
}
