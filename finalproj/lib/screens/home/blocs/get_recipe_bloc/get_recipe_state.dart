part of 'get_recipe_bloc.dart';


sealed class GetRecipeState extends Equatable {
  const GetRecipeState();

  @override
  List<Object> get props => [];
}
final class GetRecipeInitial extends GetRecipeState {}

final class GetRecipeFailure extends GetRecipeState {}
final class GetRecipeLoading extends GetRecipeState {}
final class GetRecipeSuccess extends GetRecipeState {
  final List<Recipe> recipes;

  const GetRecipeSuccess(this.recipes);

  @override
  List<Object> get props => [];
}
