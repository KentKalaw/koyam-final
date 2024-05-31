import 'package:recipe_repository/src/entities/instructions_entity.dart';
import 'package:recipe_repository/src/entities/macros_entity.dart';
import 'package:recipe_repository/src/entities/ingredients_entity.dart';
import '../models/models.dart';

class RecipeEntity {
  String recipeId;
  String picture;
  String name;
  String description;
  int time;
  String category;
  Macros macros;
  List<IngredientsEntity> ingredients;
  List<InstructionsEntity> instructions;
  double rating;
  int ratingCount;


  RecipeEntity({
    required this.recipeId,
    required this.picture,
    required this.name,
    required this.description,
    required this.time,
    required this.category,
    required this.macros,
    required this.ingredients,
    required this.instructions,
    required this.rating,
    required this.ratingCount,

});

   Map<String, Object?> toDocument() {
    return {
      'recipeId': recipeId,
      'picture': picture,
      'name': name,
      'description': description,
      'time': time,
      'category': category,
      'macros': macros.toEntity().toDocument(),
      'ingredients': ingredients.map((ingredients) => ingredients.toDocument()).toList(),
      'instructions': instructions.map((instructions) => instructions.toDocument()).toList(),
      'rating': rating,
      'ratingCount': ratingCount,

    };
  }

  static RecipeEntity fromDocument(Map<String, dynamic> doc) {
    return RecipeEntity(
            recipeId: doc['recipeId'],
            picture: doc['picture'],
            name: doc['name'],
            description: doc['description'],
            time: doc['time'],
            category: doc['category'],
            macros: Macros.fromEntity(MacrosEntity.fromDocument(doc['macros'])),
              ingredients: (doc['ingredients'] as List<dynamic>).map((ingredientDoc) => IngredientsEntity.fromDocument(ingredientDoc)).toList(),
              instructions: (doc['instructions'] as List<dynamic>).map((instructionDoc) => InstructionsEntity.fromDocument(instructionDoc)).toList(),
            rating: doc['rating'],
            ratingCount: doc['ratingCount']

         );
  }
}
