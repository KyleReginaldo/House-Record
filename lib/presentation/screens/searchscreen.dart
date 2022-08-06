import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:general/general.dart';

import '../../core/theme/colors.dart';
import '../../core/utils/suggestion_filter.dart';
import '../../domain/entity/suggestion_entity.dart';
import '../cubit/getrolecubit/getrole_cubit.dart';
import '../cubit/house/house_cubit.dart';
import 'detailscreen.dart';

import '../../data/model/suggestion_model.dart';
import '../../dependency.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          title: TypeAheadFormField<SuggestionModel>(
            suggestionsCallback: (query) async {
              return await SuggestionFilter().showSuggestions(query);
            },
            itemBuilder: (context, suggestion) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4,
                ),
                child: CustomText(
                  suggestion.address,
                  weight: FontWeight.w400,
                  size: 15,
                  color: color2,
                ),
              );
            },
            onSuggestionSelected: (suggestion) {
              setState(
                () {
                  searchController.text = suggestion.address;
                },
              );
            },
            textFieldConfiguration: TextFieldConfiguration(
              onSubmitted: (value) {
                final suggestion =
                    SuggestionEntity(address: searchController.text);
                if (searchController.text.isNotEmpty) {
                  context.read<HouseCubit>().addSuggestion(suggestion);
                }
                context.read<HouseCubit>().searchPayment(searchController.text);
              },
              style: const TextStyle(
                color: Colors.white,
              ),
              controller: searchController,
              decoration: InputDecoration(
                iconColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                filled: true,
                fillColor: const Color(0xff58739B).withOpacity(0.2),
                focusColor: const Color(0xff58739B).withOpacity(0.2),
                suffixIcon: IconButton(
                  onPressed: () {
                    final suggestion =
                        SuggestionEntity(address: searchController.text);
                    if (searchController.text.isNotEmpty) {
                      context.read<HouseCubit>().addSuggestion(suggestion);
                    }
                    context
                        .read<HouseCubit>()
                        .searchPayment(searchController.text);
                  },
                  icon: const Icon(
                    Icons.search,
                    color: color1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(
                    color: const Color(0xff58739B).withOpacity(0.2),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(style: BorderStyle.none),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                hintText: 'address',
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.grey),
              ),
              autocorrect: true,
            ),
            suggestionsBoxDecoration: const SuggestionsBoxDecoration(
              elevation: 0,
              color: color3,
            ),
            autoFlipDirection: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a address';
              } else {
                return null;
              }
            },
          ),
        ),
        body: BlocBuilder<HouseCubit, HouseState>(
          builder: (context, state) {
            if (state is Loaded) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomBtnText(
                        'results: ${state.houses.length.toString()}',
                        color: color1,
                      ),
                    ),
                    Column(
                      children: state.houses.map((house) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MultiBlocProvider(
                                            providers: [
                                              BlocProvider<HouseCubit>(
                                                create: (context) =>
                                                    sl<HouseCubit>(),
                                              ),
                                              BlocProvider<GetRoleCubit>(
                                                create: (context) =>
                                                    sl<GetRoleCubit>()
                                                      ..getUserInFirestore(
                                                          FirebaseAuth
                                                                  .instance
                                                                  .currentUser
                                                                  ?.email ??
                                                              'na'),
                                              ),
                                            ],
                                            child: DetailScreen(
                                              record: house,
                                              uid: house.uid,
                                            ),
                                          )));
                            },
                            selectedColor: color1,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: color1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            tileColor: color3,
                            textColor: color1,
                            title: CustomText(house.ownerName),
                            subtitle: CustomText(house.address),
                            trailing: CustomText(
                              house.phase,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            } else if (state is Loading) {
              return const LinearProgressIndicator(
                color: color1,
              );
            } else if (state is Empty) {
              return Align(
                alignment: Alignment.center,
                child: CustomText(
                  state.msg,
                  color: color1,
                  size: 25,
                  letterSpacing: 4,
                ),
              );
            }
            return const Align(
              alignment: Alignment.center,
              child: CustomText(
                'Search something',
                color: color1,
                size: 25,
                letterSpacing: 4,
              ),
            );
          },
        ));
  }
}
