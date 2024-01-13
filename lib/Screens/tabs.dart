import 'package:flutter/material.dart';
import 'package:meals_app/Data/dummy_data.dart';
import 'package:meals_app/Models/meal.dart';
import 'package:meals_app/Screens/categories.dart';
import 'package:meals_app/Screens/filters.dart';
import 'package:meals_app/Screens/meals.dart';
import 'package:meals_app/Widgets/side_drawer.dart';

const kInitailFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> _favoriteMeals = [];
  int _selectedPageIndex = 0;
  Map<Filters, bool> _selectedFilters = {
    Filters.glutenFree: false,
    Filters.lactoseFree: false,
    Filters.vegetarian: false,
    Filters.vegan: false,
  };
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

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitailFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filters.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = _selectedPageIndex == 0
        ? CategoriesScreen(_toggleMealFavouriteStatus, availableMeals)
        : MealScreen(
            title: null,
            meals: _favoriteMeals,
            onToggleFavorite: _toggleMealFavouriteStatus);
    final activePageTitle =
        _selectedPageIndex == 0 ? "Categories Available" : "Your Favorites";
    return Scaffold(
      drawer: SideDrawer(
        onSelectScreen: _setScreen,
      ),
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
