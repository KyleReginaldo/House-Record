import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import '../cubit/getrolecubit/getrole_cubit.dart';
import '../cubit/getusercubit/getuser_cubit.dart';
import '../widgets/updateuser_dialog.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/eos_icons.dart';
import '../../core/theme/colors.dart';
import '../../dependency.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomBtnText(
          'accounts',
          color: color1,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: color1,
          ),
        ),
      ),
      body: BlocBuilder<GetuserCubit, GetuserState>(
        builder: (context, state) {
          if (state is AccountLoaded) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: state.accounts.map((e) {
                      return e.email == FirebaseAuth.instance.currentUser?.email
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ListTile(
                                  leading: e.role == 'superadmin'
                                      ? const Iconify(EosIcons.admin)
                                      : e.role == 'admin'
                                          ? const Iconify(
                                              EosIcons.admin_outlined)
                                          : const Icon(
                                              Icons.person,
                                              color: color3,
                                            ),
                                  tileColor: color1,
                                  title: CustomBtnText(e.email),
                                  subtitle: CustomText(
                                    e.role,
                                    letterSpacing: 3,
                                  ),
                                  trailing:
                                      BlocBuilder<GetRoleCubit, UserState>(
                                    builder: (context, state) {
                                      if (state is SuperAdmin) {
                                        return e.role == 'superadmin'
                                            ? const SizedBox.shrink()
                                            : IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return BlocProvider
                                                            .value(
                                                          value: sl<
                                                              GetuserCubit>(),
                                                          child:
                                                              UpdateUserDialog(
                                                            email: e.email,
                                                            role: e.role,
                                                          ),
                                                        );
                                                      });
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: color3,
                                                ),
                                              );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    },
                                  )),
                            );
                    }).toList(),
                  ),
                  const CustomText(
                    'note: only SUPERADMIN can modify the roles\n++SUPERADMIN cannot change the role fo another SUPERADMIN.',
                    color: color1,
                    size: 12,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
