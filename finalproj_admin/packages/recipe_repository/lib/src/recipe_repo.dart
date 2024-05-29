import 'dart:html' as html;
import 'dart:typed_data';

import 'models/models.dart';

abstract class RecipeRepo {
  Future<List<Recipe>> getRecipe();
  Future <String> sendImage(Uint8List file, String name);
  Future<void> createRecipe(Recipe recipe);
}