import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    Key? key,
    this.meals,
  }) : super(key: key);

  static const String routeName = '/favorites';

  final List<Meal>? meals;

  @override
  Widget build(BuildContext context) {
    if (meals?.isEmpty ?? true) {
      return const Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        return MealItem(
          meal: meals![index],
        );
      },
      itemCount: meals!.length,
    );
  }
}
