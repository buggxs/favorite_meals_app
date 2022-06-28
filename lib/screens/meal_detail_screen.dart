import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({
    Key? key,
    this.toggleFavorite,
    this.isFavorite,
  }) : super(key: key);

  static const String routeName = '/meal-detail';

  final void Function(String mealId)? toggleFavorite;
  final bool Function(String mealId)? isFavorite;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final Meal meal = routeArgs['meal'] as Meal;

    Widget buildSectionTitle(String text) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline1,
        ),
      );
    }

    Widget buildContainer({required Widget child}) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        height: 200,
        width: 300,
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle('Ingredients'),
            buildContainer(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0,
                      ),
                      child: Text(meal.ingredients[index]),
                    ),
                  );
                },
                itemCount: meal.ingredients.length,
              ),
            ),
            buildSectionTitle('Steps'),
            buildContainer(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(meal.steps[index]),
                    ),
                    Divider(),
                  ],
                );
              },
              itemCount: meal.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isFavorite?.call(meal.id) ?? false
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border),
        onPressed: () => toggleFavorite?.call(meal.id),
      ),
    );
  }
}
