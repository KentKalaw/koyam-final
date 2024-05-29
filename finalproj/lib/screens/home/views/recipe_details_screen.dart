// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_repository/recipe_repository.dart';

import '../../../components/macro.dart';
import 'recipe_instructions_screen.dart';

class DetailsScreen extends StatelessWidget {
  final Recipe recipe;

  const DetailsScreen(this.recipe, {Key? key}) : super(key: key);

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              recipe.name,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 18,
                                        color: Color.fromARGB(255, 110, 110, 110),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${recipe.time.toString()}m",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: const Color.fromARGB(255, 110, 110, 110),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          MyMacroWidget(
                            title: "Calories",
                            value: recipe.macros.calories,
                            icon: FontAwesomeIcons.fire,
                          ),
                          SizedBox(width: 10),
                          MyMacroWidget(
                            title: "Protein",
                            value: recipe.macros.proteins,
                            icon: FontAwesomeIcons.dumbbell,
                          ),
                          SizedBox(width: 10),
                          MyMacroWidget(
                            title: "Fat",
                            value: recipe.macros.fat,
                            icon: FontAwesomeIcons.oilWell,
                          ),
                          SizedBox(width: 10),
                          MyMacroWidget(
                            title: "Carbs",
                            value: recipe.macros.carbs,
                            icon: FontAwesomeIcons.breadSlice,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Ingredients',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Display ingredients directly here
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: recipe.ingredients.map((ingredient) {
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
                        }).toList(),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InstructionsScreen(recipe: recipe),
                              ),
                            );
                            
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
                            'Start Cooking',
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
