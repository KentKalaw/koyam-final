// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_repository/recipe_repository.dart';
import 'recipe_details_screen.dart';
import 'recipe_service.dart';


class DelRecipeScreen extends StatefulWidget {
  final List<Recipe> recipes;
  

  const DelRecipeScreen({Key? key, required this.recipes}) : super(key: key);

  @override
  State<DelRecipeScreen> createState() => _DelRecipeScreenState();
}

class _DelRecipeScreenState extends State<DelRecipeScreen> {
  final RecipeService _recipeService = RecipeService();
  List<Recipe> filteredRecipes = [];
  late TextEditingController _searchController;
  List<DocumentSnapshot<Map<String, dynamic>>> favorites = [];

  @override
  void initState() {
    super.initState();
    filteredRecipes = widget.recipes;
    _searchController = TextEditingController();
    _fetchFavorites();
  }

  void _fetchFavorites() {
  _recipeService.getFavoritesWithDetails().listen((List<DocumentSnapshot<Map<String, dynamic>>>? userFavorites) {
    if (userFavorites != null) {
      setState(() {
        favorites = userFavorites;
      });
    }
  });
}

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecipes(String query) {
    setState(() {
      filteredRecipes = widget.recipes
          .where((recipe) => recipe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Recipes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterRecipes,
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                final isFavorite = favorites
                      .map((snapshot) => snapshot.data()!['recipeId'])
                      .toList()
                      .contains(filteredRecipes[index].recipeId);
                return Material(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => DetailsScreen(recipe),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                recipe.picture,
                                width: double.infinity,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                                final recipeId = filteredRecipes[index].recipeId;
                                                _recipeService.toggleFavorite(recipeId, filteredRecipes[index].name, filteredRecipes[index].picture, filteredRecipes[index].time, filteredRecipes[index].category);
                                                _fetchFavorites();
                                              },
                                              icon: Icon(
                                                isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                                                color: isFavorite ? Colors.red : Colors.black,
                                                size: 23,)
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.category,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          recipe.category,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "${recipe.time.toString()} mins",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                recipe.name,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}