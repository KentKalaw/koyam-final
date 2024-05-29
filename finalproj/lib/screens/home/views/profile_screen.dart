
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../blocs/my_user_bloc/my_user_bloc.dart';
import '../../../blocs/update_info_bloc/update_info_bloc.dart';
import '../../auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          setState(() {
            context.read<MyUserBloc>().state.user!.picture = state.userImage;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: [
            IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: Icon(
                CupertinoIcons.square_arrow_right,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<MyUserBloc, MyUserState>(
            builder: (context, state) {
              if (state.status == MyUserStatus.success) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery,
                          maxHeight: 500,
                          maxWidth: 500,
                          imageQuality: 40,
                        );
                        if (image != null) {
                          CroppedFile? croppedFile = await ImageCropper().cropImage(
                            sourcePath: image.path,
                            aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
                            aspectRatioPresets: [
                              CropAspectRatioPreset.square,
                            ],
                            uiSettings: [
                              AndroidUiSettings(
                                toolbarTitle: 'Cropper',
                                toolbarColor: Theme.of(context).colorScheme.primary,
                                toolbarWidgetColor: Colors.white,
                                initAspectRatio: CropAspectRatioPreset.original,
                                lockAspectRatio: false,
                              ),
                              IOSUiSettings(
                                title: 'Cropper',
                              ),
                              WebUiSettings(
                                context: context,
                              ),
                            ],
                          );
                          if (croppedFile != null) {
                            context.read<UpdateUserInfoBloc>().add(
                              UploadPicture(
                                croppedFile.path,
                                context.read<MyUserBloc>().state.user!.userId,
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: state.user!.picture.isEmpty ? Colors.grey.shade300 : Colors.grey,
                          shape: BoxShape.circle,
                          image: state.user!.picture.isEmpty
                              ? null
                              : DecorationImage(
                                  image: NetworkImage(
                                    state.user!.picture!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: state.user!.picture.isEmpty
                            ? Icon(
                                CupertinoIcons.person,
                                color: Colors.grey.shade400,
                                size: 80,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${state.user!.name}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
