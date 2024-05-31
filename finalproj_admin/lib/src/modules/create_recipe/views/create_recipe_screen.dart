// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finalproj_admin/src/modules/create_recipe/blocs/create_recipe_bloc/create_recipe_bloc.dart';
import 'package:finalproj_admin/src/modules/create_recipe/blocs/upload_picture_bloc/upload_picture_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:recipe_repository/recipe_repository.dart';

import '../../../components/my_text_field.dart';
import '../components/macro.dart';
import 'ingredients_controller.dart';
import 'instructions_controller.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final nameController = TextEditingController();
  final timeController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final caloriesController = TextEditingController();
  final proteinsController = TextEditingController();
  final fatController = TextEditingController();
  final carbsController = TextEditingController();
  List<IngredientControllers> ingredientsControllers = [];
  List<InstructionControllers> instructionsControllers = [];
  bool creationRequired = false;

  final _formKey = GlobalKey<FormState>();
  String? _errorMsg;
  late Recipe recipe;

  @override
  void initState() {
    recipe = Recipe.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateRecipeBloc, CreateRecipeState>(
      listener: (context, state) {
        if(state is CreateRecipeSuccess) {
					setState(() {
					  creationRequired = false;
            context.go('/');
					});
          context.go('/');
				} else if(state is CreateRecipeLoading) {
					setState(() {
					  creationRequired = true;
					});
				} 
      },
      child: BlocListener<UploadPictureBloc, UploadPictureState>(
        listener: (context, state) {
          if (state is UploadPictureLoading) {
          } else if (state is UploadPictureSuccess) {
            setState(() {
              recipe.picture = state.url;
              print(recipe.picture);
            });
          } else {}
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create a New Recipe !',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 1000,
                        maxWidth: 1000,
                      );
                      if (image != null && context.mounted) {
                        context.read<UploadPictureBloc>().add(UploadPicture(
                            await image.readAsBytes(), basename(image.path)));
                      }
                    },
                    child: recipe.picture.startsWith(('http'))
                        ? Container(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(recipe.picture),
                                    fit: BoxFit.cover)))
                        : Ink(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.photo,
                                  size: 100,
                                  color: Colors.grey.shade200,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Add a Picture here...",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            controller: nameController,
                            hintText: 'Name',
                            suffixIcon: Icon(
                              CupertinoIcons.pencil_ellipsis_rectangle,
                              color: const Color.fromARGB(255, 110, 110, 110),
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            errorMsg: _errorMsg,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            controller: timeController,
                            hintText: 'Time',
                            suffixIcon: Icon(
                              CupertinoIcons.timer,
                              color: const Color.fromARGB(255, 110, 110, 110),
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            errorMsg: _errorMsg,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            controller: descriptionController,
                            hintText: 'Description',
                            suffixIcon: Icon(
                              CupertinoIcons.textformat_abc,
                              color: const Color.fromARGB(255, 110, 110, 110),
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            errorMsg: _errorMsg,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              }
                              return null;
                            },
                          ),
                        ),
                        
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            controller: categoryController,
                            hintText: 'Categories',
                            suffixIcon: Icon(
                              CupertinoIcons.chevron_down_square,
                              color: const Color.fromARGB(255, 110, 110, 110),
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            errorMsg: _errorMsg,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...ingredientsControllers.asMap().entries.map(
                                    (entry) => Row(
                                      children: [
                                        Expanded(
                                          child: MyTextField(
                                            controller: entry.value.nameController,
                                            hintText: 'Ingredient Name',
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
                                            // Add other properties such as validator, suffixIcon, etc.
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: MyTextField(
                                            controller: entry.value.quantityController,
                                            hintText: 'Quantity',
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
                                            // Add other properties such as validator, suffixIcon, etc.
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            setState(() {
                                              ingredientsControllers.removeAt(entry.key);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              ingredientsControllers.add(IngredientControllers(
                                                nameController: TextEditingController(),
                                                quantityController: TextEditingController(),
                                              ));
                                            });
                                          },
                                          icon: Icon(Icons.add, color: Colors.black,),
                                          label: Text('Add Ingredient', style: TextStyle(color: Colors.black),),
                                        ),
                                      ),
                                    ],
                                  ),

                    SizedBox(height: 10),

                        ...instructionsControllers.asMap().entries.map(
                                    (entry) => Row(
                                      children: [
                                        Expanded(
                                          child: MyTextField(
                                            controller: entry.value.stepsController,
                                            hintText: 'Steps',
                                            obscureText: false,
                                            keyboardType: TextInputType.text,
                                            // Add other properties such as validator, suffixIcon, etc.
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            setState(() {
                                              instructionsControllers.removeAt(entry.key);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              instructionsControllers.add(InstructionControllers(
                                                stepsController: TextEditingController(),
                                              ));
                                            });
                                          },
                                          icon: Icon(Icons.add, color: Colors.black,),
                                          label: Text('Add Steps', style: TextStyle(color: Colors.black),),
                                        ),
                                      ),
                                    ],
                                  ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Macros:'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              MyMacroWidget(
                                title: "Calories",
                                value: 12,
                                icon: FontAwesomeIcons.fire,
                                controller: caloriesController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MyMacroWidget(
                                title: "Protein",
                                value: 12,
                                icon: FontAwesomeIcons.dumbbell,
                                controller: proteinsController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MyMacroWidget(
                                title: "Fat",
                                value: 12,
                                icon: FontAwesomeIcons.oilWell,
                                controller: fatController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MyMacroWidget(
                                title: "Carbs",
                                value: 12,
                                icon: FontAwesomeIcons.breadSlice,
                                controller: carbsController,
                              ),
                            ],
                          ),
                          
                        ),
                ],
                    ),
                  ),
                  SizedBox(height: 20),

                  
                  !creationRequired
                      ? SizedBox(
                          width: 400,
                          height: 50,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      recipe.name = nameController.text;
                                      recipe.time =
                                          int.parse(timeController.text);
                                      recipe.description =
                                          descriptionController.text;
                                      recipe.category =
                                          categoryController.text;
                                      recipe.macros.calories =
                                          int.parse(caloriesController.text);
                                      recipe.macros.proteins =
                                          int.parse(proteinsController.text);
                                      recipe.macros.fat =
                                          int.parse(fatController.text);
                                      recipe.macros.carbs =
                                          int.parse(carbsController.text);
                                           recipe.ingredients = ingredientsControllers
                                          .map((controller) => Ingredients(
                                        name: controller.nameController.text,
                                        quantity: controller.quantityController.text,
                                      ))
                                          .toList();
                                          recipe.instructions = instructionsControllers
                                          .map((controller) => Instructions(
                                        steps: controller.stepsController.text,
                                      ))
                                          .toList();
                                      
                                      
                                    });
                                    print(recipe.toString());
                                    context
                                        .read<CreateRecipeBloc>()
                                        .add(CreateRecipe(recipe));
                                  }
                                },
                                style: TextButton.styleFrom(
                                    elevation: 5.0,
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 5),
                                  child: Text(
                                    'Create Recipe',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
