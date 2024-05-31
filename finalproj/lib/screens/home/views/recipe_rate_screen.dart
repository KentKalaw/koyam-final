import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipe_repository/recipe_repository.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_screen.dart';

class RateScreen extends StatelessWidget {
  final Recipe recipe;
  const RateScreen({required this.recipe, super.key});

  Future<void> updateRating(double rating) async {
    // Reference to the specific recipe document in Firestore
    final recipeRef = FirebaseFirestore.instance.collection('recipes').doc(recipe.recipeId);

    // Get the current rating and rating count
    final snapshot = await recipeRef.get();
    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null) {
        final currentRating = data['rating'] as double? ?? 0.0;
        final ratingCount = data['ratingCount'] as int? ?? 0;

        // Calculate the new rating
        final newRating = ((currentRating * ratingCount) + rating) / (ratingCount + 1);

        // Update the rating and rating count in Firestore
        await recipeRef.update({
          'rating': newRating,
          'ratingCount': ratingCount + 1,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 6,
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                      recipe.picture,
                      scale: 1.0,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.name,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Rate the food!",
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 5),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          onRatingUpdate: (rating) async {
                            print(rating);
                            await updateRating(rating);
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                             Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          style: TextButton.styleFrom(
                            elevation: 5.0,
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Done',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
