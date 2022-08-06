import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:general/general.dart';
import 'package:house_record/presentation/cubit/getrolecubit/getrole_cubit.dart';
import 'package:intl/intl.dart';
import '../../core/theme/color_filter.dart';
import '../../core/utils/helper_widget.dart';
import '../../core/utils/suggestion_filter.dart';
import '../../data/model/suggestion_model.dart';
import '../../domain/entity/suggestion_entity.dart';
import '../cubit/history/history_cubit.dart';

import '../../core/theme/colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final searchController = TextEditingController();
  bool isExpanded = false;
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
                context.read<HistoryCubit>().addSuggestion(suggestion);
              }
              context.read<HistoryCubit>().searchHistory(searchController.text);
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
                    context.read<HistoryCubit>().addSuggestion(suggestion);
                  }
                  context
                      .read<HistoryCubit>()
                      .searchHistory(searchController.text);
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
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Loaded) {
            return SingleChildScrollView(
                child: Container(
              padding: const EdgeInsets.all(5),
              child: ExpansionPanelList.radio(
                dividerColor: Colors.black,
                animationDuration: const Duration(milliseconds: 600),
                elevation: 1,
                children: state.history.map((e) {
                  return ExpansionPanelRadio(
                    backgroundColor: alternateColor(state.history, e),
                    canTapOnHeader: true,
                    value: e.address,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: CustomText(
                          e.address.toUpperCase(),
                          color: color1,
                        ),
                        subtitle: CustomText(
                          e.phase.split(',').first,
                          color: color1,
                        ),
                      );
                    },
                    body: Card(
                      shadowColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: CustomText(
                                e.ownerName.toUpperCase(),
                                weight: FontWeight.bold,
                                color: color1,
                                size: 20,
                              ),
                            ),
                            addVerticalSpace(40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  'payment number',
                                  color: color1,
                                ),
                                CustomText(
                                  e.paymentNumber,
                                  color: color1,
                                ),
                              ],
                            ),
                            addVerticalSpace(16),
                            const HDivider(
                              splitter: 40,
                              isDot: true,
                              color: color1,
                            ),
                            addVerticalSpace(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  'amount',
                                  color: color1,
                                ),
                                CustomText(
                                  NumberFormat.currency(
                                          locale: 'fil',
                                          symbol: '₱',
                                          decimalDigits: 2)
                                      .format(
                                    double.parse(e.amount),
                                  ),
                                  color: color1,
                                ),
                              ],
                            ),
                            addVerticalSpace(16),
                            const HDivider(
                              splitter: 40,
                              isDot: true,
                              color: color1,
                            ),
                            addVerticalSpace(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  'covered month',
                                  color: color1,
                                ),
                                CustomText(
                                  e.coveredMonth.toUpperCase(),
                                  color: color1,
                                ),
                              ],
                            ),
                            addVerticalSpace(16),
                            const HDivider(
                              splitter: 40,
                              isDot: true,
                              color: color1,
                            ),
                            addVerticalSpace(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  'date',
                                  color: color1,
                                ),
                                CustomText(
                                  e.date,
                                  color: color1,
                                ),
                              ],
                            ),
                            addVerticalSpace(16),
                            const HDivider(
                              splitter: 40,
                              isDot: true,
                              color: color1,
                            ),
                            addVerticalSpace(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  'added by',
                                  color: color1,
                                ),
                                CustomText(
                                  e.manager,
                                  color: color1,
                                ),
                              ],
                            ),
                            addVerticalSpace(16),
                            Align(
                              alignment: Alignment.center,
                              child: BlocBuilder<GetRoleCubit, UserState>(
                                builder: (context, state) {
                                  if (state is Collector) {
                                    return IconButton(
                                      onPressed: () {
                                        context
                                            .read<HistoryCubit>()
                                            .deleteHistory(e.ownerName);
                                        context
                                            .read<HistoryCubit>()
                                            .getHistory();
                                      },
                                      icon: const Icon(Icons.delete,
                                          color: color1),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ));
          } else if (state is Empty) {
            return const Center(
                child: CustomText('Empty', color: Colors.white));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
