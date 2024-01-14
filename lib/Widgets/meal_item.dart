import 'package:flutter/material.dart';
import 'package:meals_app/Models/meal.dart';
import 'package:meals_app/Widgets/meal_item_traits.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem(this.meal, this.onSelectMeal, {super.key});
  final Meal meal;
  final void Function(Meal meal) onSelectMeal;
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 24,
      child: InkWell(
        onTap: () => onSelectMeal(meal),
        child: Stack(
          children: [
            Stack(
              children: [
                Hero(
                  tag: meal.id,
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(meal.imageUrl),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          meal.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                MealItemTraits(
                                    Icons.schedule, "${meal.duration} mins"),
                                const SizedBox(
                                  width: 12,
                                ),
                                MealItemTraits(Icons.work, complexityText),
                                const SizedBox(
                                  width: 12,
                                ),
                                MealItemTraits(
                                    Icons.attach_money, affordabilityText),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
