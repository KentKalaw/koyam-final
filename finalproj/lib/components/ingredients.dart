import 'package:flutter/material.dart';
import 'package:recipe_repository/recipe_repository.dart'; // Import your Ingredients model

class MyIngredientWidget extends StatelessWidget {
  final List<Ingredients> ingredients;

  const MyIngredientWidget({Key? key, required this.ingredients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ingredients
              .map((ingredient) => IngredientItem(ingredient: ingredient))
              .toList(),
        ),
      ],
    );
  }
}

class IngredientItem extends StatelessWidget {
  final Ingredients ingredient;

  const IngredientItem({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              ingredient.name,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                ingredient.quantity,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
