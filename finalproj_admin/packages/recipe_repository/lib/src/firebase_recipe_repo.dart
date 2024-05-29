import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../recipe_repository.dart';
import 'dart:html' as html;

class FirebaseRecipeRepo implements RecipeRepo {
  final recipeCollection = FirebaseFirestore.instance.collection('recipes');

  @override
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

  @override
  Future <String> sendImage(Uint8List file, String name) async {
    try {
      Reference firebaseStorageRef = FirebaseStorage
      .instance
      .ref()
      .child(name);

      await firebaseStorageRef.putBlob(file);
      return await firebaseStorageRef.getDownloadURL();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createRecipe(Recipe recipe) async {
    try {
      return await recipeCollection
      .doc(recipe.recipeId)
      .set(recipe.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}