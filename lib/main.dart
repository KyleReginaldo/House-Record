// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:house_record/core/theme/colors.dart';
import 'package:house_record/core/theme/text_theme.dart';
import 'package:house_record/data/model/house_record_model.dart';
import 'package:house_record/data/model/suggestion_model.dart';
import 'package:house_record/presentation/cubit/history/history_cubit.dart';
import 'package:house_record/presentation/cubit/house/house_cubit.dart';
import 'package:house_record/presentation/screens/auth_screen.dart';
import 'dependency.dart' as dependency;
import 'dependency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dependency.init();
  await Hive.initFlutter();
  Hive.registerAdapter(SuggestionModelAdapter());
  Hive.registerAdapter(HouseRecordModelAdapter());
  await Hive.openBox('Suggestions_edited');
  await Hive.openBox('HistoryRecord');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'House Record',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: quicksandTextTheme,
        primaryColor: color1,
        buttonTheme: const ButtonThemeData(buttonColor: color1),
        appBarTheme: const AppBarTheme(color: color3),
        scaffoldBackgroundColor: color4,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HouseCubit>(
            create: (context) => sl<HouseCubit>(),
          ),
          BlocProvider<HistoryCubit>(
            create: (context) => sl<HistoryCubit>(),
          ),
        ],
        child: const AuthScreen(),
      ),
    );
  }
}
