import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/helper_widget.dart';
import '../cubit/getusercubit/getuser_cubit.dart';
import '../cubit/house/house_cubit.dart';
import 'register_screen.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../../dependency.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogINState();
}

class _LogINState extends State<LogInScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isObscure = true;
  int _current = 0;
  List<int> indexList = [0, 1, 2, 3];
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              CarouselSlider(
                items: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/note.png',
                        height: 150,
                      ),
                      const CustomText(
                        'tired of writing your payment information in paper?',
                        color: Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/idea.png',
                        height: 150,
                      ),
                      const CustomText(
                        'you just got the right application for your problem',
                        color: Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/desktop-computer.png',
                        height: 150,
                      ),
                      const CustomText(
                        'this application can help you store information and manage it at ease',
                        color: Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/warehouse.png',
                        height: 150,
                      ),
                      const CustomText(
                        'write freely with House Record app',
                        color: Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
                options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indexList.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                      ? color1
                                      : color3)
                                  .withOpacity(_current == entry ? 0.9 : 0.4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ]),
            addVerticalSpace(20),
            CustomTextField(
              'email',
              controller: email,
              keyboard: TextInputType.emailAddress,
              color: color1,
              radius: 0,
              prefix: const Icon(
                Icons.email_outlined,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'email is empty';
                } else if (!value.contains('@')) {
                  return 'invalid format';
                }
                return null;
              },
            ),
            addVerticalSpace(16),
            CustomTextField(
              'password',
              controller: password,
              obscureText: isObscure,
              color: color1,
              radius: 0,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'email is empty';
                } else if (value.length < 6) {
                  return 'too short';
                }
                return null;
              },
              prefix: const Icon(
                Icons.lock_open_rounded,
              ),
              suffix: IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: isObscure
                    ? const Iconify(Mdi.eye_off_outline)
                    : const Iconify(Mdi.eye_outline),
              ),
            ),
            addVerticalSpace(25),
            BtnBorder(
              width: 180,
              onTap: () async {
                context.read<HouseCubit>().logIn(email.text, password.text);
              },
              text: 'log in',
              color: Theme.of(context).primaryColor,
            ),
            BtnTextOnly(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: sl<GetuserCubit>(),
                      child: const RegisterScreen(),
                    ),
                  ),
                );
              },
              text: 'dont have account? Register',
            ),
          ],
        ),
      ),
    );
  }
}
