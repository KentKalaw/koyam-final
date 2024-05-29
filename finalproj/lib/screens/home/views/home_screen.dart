// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:finalproj/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:finalproj/screens/home/blocs/get_recipe_bloc/get_recipe_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'del_recipe_screen.dart';
import '../../../components/home_app_bar.dart';
import 'recipe_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

@override
void dispose() {
  _searchController.dispose();
  super.dispose();
}
  String selectedCategory = 'All';

  final List<String> categories = ['All', 'Breakfast', 'Lunch', 'Dinner'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          children: [
            Image.asset(
              'lib/images/koyam-logo.png',
              scale: 10,
            ),
            const SizedBox(width: 8),
            Text(
              "RECIPES",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeAppBar(),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DelRecipeScreen(recipes: [],),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('lib/images/explore-final.png'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Categories',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ChoiceChip(
                              label: Text(category),
                              selected: selectedCategory == category,
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedCategory = selected ? category : 'All';
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delicious Recipes',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (context.read<GetRecipeBloc>().state is GetRecipeSuccess) {
                              final recipes = (context.read<GetRecipeBloc>().state as GetRecipeSuccess).recipes;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DelRecipeScreen(recipes: recipes),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'View all',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            Container(
              height: 250,
              child: BlocBuilder<GetRecipeBloc, GetRecipeState>(
                builder: (context, state) {
                  if (state is GetRecipeSuccess) {
                    final filteredRecipes = selectedCategory == 'All'
                        ? state.recipes
                        : state.recipes.where((recipe) => recipe.category == selectedCategory).toList();

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredRecipes.length,
                      itemBuilder: (context, int i) {
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
                                  builder: (BuildContext context) => DetailsScreen(filteredRecipes[i]),
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
                                        filteredRecipes[i].picture,
                                        width: 300,
                                        height: 140,
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
                                            onPressed: () {},
                                            icon: Icon(
                                              CupertinoIcons.heart,
                                              color: Colors.black,
                                              size: 23,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 35.0),
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
                                                  "${filteredRecipes[i].category}",
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
                                                  "${filteredRecipes[i].time.toString()} mins",
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
                                        filteredRecipes[i].name,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0), 
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        filteredRecipes[i].description,
                                        style: GoogleFonts.poppins(
                                          color: Color.fromARGB(255, 110, 110, 110),
                                          fontSize: 13,
                                        ),
                                        maxLines: 2,  // Limit to 2 lines
                                        overflow: TextOverflow.ellipsis,
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
                    );
                  } else if (state is GetRecipeLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                      child: Text('Error occurred.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}