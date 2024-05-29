import 'dart:html' as html;
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_repository/recipe_repository.dart';

part 'upload_picture_event.dart';
part 'upload_picture_state.dart';

class UploadPictureBloc extends Bloc<UploadPictureEvent, UploadPictureState> {
  RecipeRepo recipeRepo;
  UploadPictureBloc(this.recipeRepo) : super(UploadPictureLoading()) {
    on<UploadPicture>((event, emit) async {
      try {
        String url = await recipeRepo.sendImage(event.file, event.name);
        emit(UploadPictureSuccess(url));
      } catch (e) {
        emit(UploadPictureFailure());
      }
      
    });
  }
}
