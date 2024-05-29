part of 'get_recipe_bloc.dart';


sealed class GetRecipeEvent extends Equatable{
  const GetRecipeEvent();

  @override
  List<Object> get props => [];
}

class GetRecipe extends GetRecipeEvent{}
