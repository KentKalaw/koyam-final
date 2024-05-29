import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_repository/recipe_repository.dart';


part 'get_recipe_event.dart';
part 'get_recipe_state.dart';

class GetRecipeBloc extends Bloc<GetRecipeEvent, GetRecipeState> {
  final RecipeRepo _recipeRepo;

  GetRecipeBloc(this._recipeRepo) : super(GetRecipeInitial()) {
    on<GetRecipe>((event, emit) async {
  emit(GetRecipeLoading());
  try {
    List<Recipe> recipes = await _recipeRepo.getRecipe();
    emit(GetRecipeSuccess(recipes));
  } on FirebaseException catch (e) {
    // Handle specific Firebase exceptions
    print('Firebase Exception: ${e.message}');
    emit(GetRecipeFailure());
  } catch (e) {
    // Handle other exceptions
    print('Error: $e');
    emit(GetRecipeFailure());
  }
});
  }
}