import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_repository/recipe_repository.dart';

part 'create_recipe_event.dart';
part 'create_recipe_state.dart';

class CreateRecipeBloc extends Bloc<CreateRecipeEvent, CreateRecipeState> {
  RecipeRepo recipeRepo;
  CreateRecipeBloc(this.recipeRepo) : super(CreateRecipeInitial()) {
    on<CreateRecipe>((event, emit) async {
     emit(CreateRecipeLoading());
     try {
        await recipeRepo.createRecipe(event.recipe);
        emit(CreateRecipeSuccess());
      } catch (e) {
        emit(CreateRecipefailure());
      }
    });
  }
}
