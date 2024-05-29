import 'package:finalproj/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_repository/recipe_repository.dart';
import 'blocs/my_user_bloc/my_user_bloc.dart';
import 'blocs/update_info_bloc/update_info_bloc.dart';
import 'screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'screens/auth/views/welcome_screen.dart';
import 'screens/home/blocs/get_recipe_bloc/get_recipe_bloc.dart';
import 'screens/home/views/main_page.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koyam Recette',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.light(
        background: Colors.grey.shade200,
        onBackground: Colors.black,
        primary: Colors.grey.shade300,
        onPrimary: Colors.white,
      )),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ((context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                      context.read<AuthenticationBloc>().userRepository),
                ),
                BlocProvider(
                  create: (context) => GetRecipeBloc(
                    FirebaseRecipeRepo()
                  )..add(GetRecipe()),
                ),
                BlocProvider(
                  create: (context) => UpdateUserInfoBloc(
                    userRepository: context.read<AuthenticationBloc>().userRepository
										),
                ),
                BlocProvider(
                  create: (context) => MyUserBloc(
                    myUserRepository: context.read<AuthenticationBloc>().userRepository
                  )..add(GetMyUser(
                    myUserId: context.read<AuthenticationBloc>().state.user!.userId
                  )),
                ),
              ],
              child: const HomePage(),
            );
          } else {
            return const WelcomeScreen();
          }
        }),
      ),
    );
  }
}
