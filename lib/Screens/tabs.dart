import 'package:flutter/material.dart';
import 'package:meals_app/Models/meal.dart';
import 'package:meals_app/Screens/categories.dart';
import 'package:meals_app/Screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> _favoriteMeals = [];
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    setState(
      () {
        if (_favoriteMeals.contains(meal)) {
          _favoriteMeals.remove(meal);
          _showInfoMessage("Removed from Favorites");
        } else {
          _favoriteMeals.add(meal);
          _showInfoMessage("Added to Favorites");
        }
      },
    );
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = _selectedPageIndex == 0
        ? CategoriesScreen(_toggleMealFavouriteStatus)
        : MealScreen(
            title: null,
            meals: _favoriteMeals,
            onToggleFavorite: _toggleMealFavouriteStatus);
    final activePageTitle =
        _selectedPageIndex == 0 ? "Categories Available" : "Your Favorites";
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
