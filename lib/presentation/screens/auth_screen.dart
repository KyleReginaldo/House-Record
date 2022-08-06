import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/getusercubit/getuser_cubit.dart';
import '../cubit/house/house_cubit.dart';
import 'homescreen.dart';
import 'login_screen.dart';

import '../../dependency.dart';
import '../cubit/getrolecubit/getrole_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data as User;

          return MultiBlocProvider(
            providers: [
              BlocProvider<HouseCubit>(
                create: (context) => sl<HouseCubit>(),
              ),
              BlocProvider<GetRoleCubit>(
                create: (context) =>
                    sl<GetRoleCubit>()..getUserInFirestore(user.email!),
              ),
              BlocProvider<GetuserCubit>(
                create: (context) => sl<GetuserCubit>(),
              ),
            ],
            child: const HomeScreen(),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        } else {
          return const LogInScreen();
        }
      },
    );
  }
}
