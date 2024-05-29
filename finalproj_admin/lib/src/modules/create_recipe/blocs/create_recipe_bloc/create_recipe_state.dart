part of 'create_recipe_bloc.dart';

sealed class CreateRecipeState extends Equatable {
  const CreateRecipeState();
  
  @override
  List<Object> get props => [];
}

final class CreateRecipeInitial extends CreateRecipeState {}

final class CreateRecipefailure extends CreateRecipeState {}
final class CreateRecipeLoading extends CreateRecipeState {}
final class CreateRecipeSuccess extends CreateRecipeState {}
