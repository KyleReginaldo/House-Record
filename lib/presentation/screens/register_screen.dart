import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import '../../core/utils/helper_widget.dart';
import '../../domain/entity/user_entity.dart';
import '../cubit/getusercubit/getuser_cubit.dart';

import '../../core/theme/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isAccepted = false;
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final repass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                'username',
                controller: username,
                color: color1,
                radius: 0,
                prefix: const Icon(
                  Icons.person,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                'email',
                controller: email,
                color: color1,
                radius: 0,
                prefix: const Icon(
                  Icons.email_outlined,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                'password',
                controller: password,
                color: color1,
                radius: 0,
                prefix: const Icon(
                  Icons.lock,
                ),
                validator: (value) {
                  if (value!.length < 6) {
                    return 'too weak';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                're-type password',
                controller: repass,
                color: color1,
                radius: 0,
                prefix: const Icon(
                  Icons.lock,
                ),
                validator: (value) {
                  if (value != password.text) {
                    return 'password dont match';
                  }
                  return null;
                },
              ),
            ),
            addVerticalSpace(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isAccepted,
                  onChanged: (value) {
                    setState(() {
                      isAccepted = !isAccepted;
                    });
                  },
                ),
                const CustomText(
                  'Accept terms and condition',
                  color: color2,
                ),
              ],
            ),
            BtnBorder(
              onTap: () async {
                final user = UserEntity(
                  email: email.text,
                  password: password.text,
                  role: 'user',
                  username: username.text,
                );

                if (isAccepted) {
                  context.read<GetuserCubit>().createUserAccount(user);
                  Navigator.pop(context);
                }
              },
              text: 'Register',
              color: color1,
            ),
          ],
        ),
      ),
    );
  }
}
