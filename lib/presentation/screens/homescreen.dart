import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:house_record/presentation/cubit/history/history_cubit.dart';
import '../cubit/getrolecubit/getrole_cubit.dart';
import '../widgets/drawer.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/teenyicons.dart';

import '../cubit/house/house_cubit.dart';
import 'searchscreen.dart';
import 'houselist_screen.dart';

import '../../core/theme/colors.dart';
import '../../dependency.dart';
import '../widgets/add_dialog.dart';

//Lagay mo to later sa global variable

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'HOUSE RECORD',
          letterSpacing: 2,
          size: 15,
          weight: FontWeight.bold,
          color: color1,
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider<HouseCubit>(
                            create: (context) => sl<HouseCubit>(),
                            child: const SearchScreen(),
                          )));
            },
            icon: const Iconify(
              Teenyicons.search_property_outline,
              color: color1,
            ),
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(8),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<HouseCubit>(
                      create: (context) =>
                          sl<HouseCubit>()..getHouses('phase 1'),
                    ),
                    BlocProvider<GetRoleCubit>(
                      create: (context) => sl<GetRoleCubit>(),
                    ),
                  ],
                  child: const HouseListScreen(),
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: color3,
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/phase1.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                ),
              ),
              child: const Center(
                child: CustomBtnText(
                  'PHASE 1',
                  weight: FontWeight.bold,
                  letterSpacing: 5,
                  size: 20,
                  color: color1,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<HouseCubit>(
                      create: (context) =>
                          sl<HouseCubit>()..getHouses('phase 2a,(joan)'),
                    ),
                    BlocProvider<GetRoleCubit>(
                      create: (context) => sl<GetRoleCubit>(),
                    ),
                  ],
                  child: const HouseListScreen(),
                ),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color3,
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/phase2.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                ),
              ),
              child: const Center(
                child: CustomBtnText(
                  'PHASE 2a(1-47)',
                  weight: FontWeight.bold,
                  letterSpacing: 5,
                  size: 20,
                  textAlign: TextAlign.center,
                  color: color1,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<HouseCubit>(
                      create: (context) => sl<HouseCubit>()
                        ..getHouses('phase 2a,(sarahmostajo)'),
                    ),
                    BlocProvider<GetRoleCubit>(
                      create: (context) => sl<GetRoleCubit>(),
                    ),
                  ],
                  child: const HouseListScreen(),
                ),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color3,
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/phase2a.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                ),
              ),
              child: const Center(
                child: CustomBtnText(
                  'PHASE 2a(48-87)',
                  weight: FontWeight.bold,
                  letterSpacing: 5,
                  size: 20,
                  color: color1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<HouseCubit>(
                      create: (context) =>
                          sl<HouseCubit>()..getHouses('phase 2b'),
                    ),
                    BlocProvider<GetRoleCubit>(
                      create: (context) => sl<GetRoleCubit>(),
                    ),
                  ],
                  child: const HouseListScreen(),
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: color3,
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/phase2b.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                ),
              ),
              child: const Center(
                child: CustomBtnText(
                  'PHASE 2b',
                  weight: FontWeight.bold,
                  letterSpacing: 5,
                  size: 20,
                  color: color1,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<GetRoleCubit, UserState>(
        builder: (context, state) {
          if (state is Collector) {
            return FloatingActionButton(
              backgroundColor: color1,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<HouseCubit>(
                        create: (context) => sl<HouseCubit>(),
                      ),
                      BlocProvider<HistoryCubit>(
                        create: (context) => sl<HistoryCubit>(),
                      ),
                    ],
                    child: AddDialog(
                      username: state.user.username,
                    ),
                  ),
                );
              },
              tooltip: 'Add Record',
              splashColor: color1,
              child: const Icon(
                Icons.add_home_outlined,
                color: color3,
                size: 35,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      drawer: const MyDrawer(),
    );
  }
}
