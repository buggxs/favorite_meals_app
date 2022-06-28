import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  const CategoryMealsScreen({
    Key? key,
    required this.availableMeals,
  }) : super(key: key);

  final List<Meal> availableMeals;

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  void _removeMeal(String mealId) {
    setState(() {
      categoryMeals.removeWhere((element) => element.id == mealId);
    });
  }

  String? categoryTitle;
  late List<Meal> categoryMeals;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final String? categoryId = routeArgs['id'];

    categoryMeals = widget.availableMeals
        .where((element) => element.categories.contains(categoryId))
        .toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle ?? 'Unknown'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            meal: categoryMeals[index],
            onRemove: (Meal meal) {
              _removeMeal(meal.id);
            },
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
