import 'package:flutter/material.dart';
// import 'package:meals_app/Screens/tabs.dart';
// import 'package:meals_app/Widgets/side_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: SideDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'Meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: _glutenFree,
            onChanged: (isChecked) {
              setState(
                () {
                  _glutenFree = isChecked;
                },
              );
            },
            title: Text(
              "Gluten-Free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              "Only include gluten-free meals",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}