import '../entities/entities.dart';
import 'models.dart';

class Recipe {
  final String recipeId;
  final String picture;
  final String name;
  final String description;
  final int time;
  final String category;
  final Macros macros;
  final List<Ingredients> ingredients;
  final List<Instructions> instructions;


  Recipe({
    required this.recipeId,
    required this.picture,
    required this.name,
    required this.description,
    required this.time,
    required this.category,
    required this.macros,
    required this.ingredients,
    required this.instructions,

});

    RecipeEntity toEntity() {
    return RecipeEntity(
      recipeId: recipeId,
      picture: picture,
      name: name,
      description: description,
      time: time,
      category: category,
      macros: macros,
      ingredients: ingredients.map((ingredients) => ingredients.toEntity()).toList(),
      instructions: instructions.map((instructions) => instructions.toEntity()).toList(),
      
    );
  }

  static Recipe fromEntity(RecipeEntity entity) {
    return Recipe(
      recipeId: entity.recipeId,
      picture: entity.picture,
      name: entity.name,
      description: entity.description,
      time: entity.time,
      category: entity.category,
      macros: entity.macros,
      ingredients: entity.ingredients.map((ingredientEntity) => Ingredients(
        name: ingredientEntity.name,
        quantity: ingredientEntity.quantity,
      )).toList(),
      instructions: entity.instructions.map((instructionsEntity) => Instructions(
        steps: instructionsEntity.steps,
      )).toList(),

    );
  }

}

