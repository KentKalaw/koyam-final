

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../recipe_repository.dart';

class FirebaseRecipeRepo implements RecipeRepo {
  final recipeCollection = FirebaseFirestore.instance.collection('recipes');

  Future<List<Recipe>> getRecipe() async {
    try {
      final querySnapshot = await recipeCollection.get();
      return querySnapshot.docs
          .map((doc) => Recipe.fromEntity(RecipeEntity.fromDocument(doc.data())))
          .toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

}