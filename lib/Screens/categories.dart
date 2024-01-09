import 'package:flutter/material.dart';
import 'package:meals_app/Data/dummy_data.dart';
import 'package:meals_app/Widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _selectCategory() {
      Navigator.of(context).pushNamed(
        '/mealscreen',
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories Available'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryItem(category, _selectCategory),
        ],
      ),
    );
  }
}
