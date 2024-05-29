import 'models/models.dart';

abstract class RecipeRepo {
  Future<List<Recipe>> getRecipe();
}