import 'package:flutter/material.dart';
import 'package:meals_app/widgets/category_item.dart';

import '../models/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/';

  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        ...DUMMY_CATEGORIES
            .map((catData) => CategoryItem(
                  id: catData.id,
                  color: catData.color,
                  title: catData.title,
                ))
            .toList(),
      ],
    );
  }
}
