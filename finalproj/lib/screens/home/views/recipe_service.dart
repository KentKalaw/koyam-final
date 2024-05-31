import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecipeService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> toggleFavorite(String recipeId, String name, String picture, int time, String category) async {
  final user = _auth.currentUser;
  if (user != null) {
    final favoritesRef = _firestore.collection('users').doc(user.uid).collection('favorites');
    final favoriteDoc = await favoritesRef.doc(recipeId).get();

    if (favoriteDoc.exists) {
      await favoritesRef.doc(recipeId).delete();
    } else {
      await favoritesRef.doc(recipeId).set({
        'recipeId': recipeId,
        'name': name,
        'picture': picture,
        'time': time,
        'category': category,
      });
    }
  }
}

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> getFavoritesWithDetails() {
  final user = _auth.currentUser;
  if (user != null) {
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  } else {
    return Stream.value([]);
  }
}

  
}

