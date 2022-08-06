import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:house_record/presentation/cubit/history/history_cubit.dart';
import 'package:house_record/presentation/widgets/history_dialog.dart';
import '../cubit/getrolecubit/getrole_cubit.dart';

import '../../core/theme/colors.dart';
import 'package:intl/intl.dart';

import '../../core/utils/helper_widget.dart';
import '../../dependency.dart';
import '../../domain/entity/house_record_entity.dart';
import '../cubit/house/house_cubit.dart';
import '../widgets/update_dialog.dart';

class DetailScreen extends StatelessWidget {
  final String uid;
  final HouseRecordEntity record;
  const DetailScreen({
    Key? key,
    required this.uid,
    required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: color1,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const CustomText(
            'RECORD DETAIL',
            letterSpacing: 2,
            color: color1,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<GetRoleCubit, UserState>(
          builder: (context, state) {
            if (state is SuperAdmin) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          record.ownerName.toUpperCase(),
                          weight: FontWeight.bold,
                          color: color1,
                          size: 20,
                        ),
                      ),
                      addVerticalSpace(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            'payment number',
                            color: color1,
                          ),
                          CustomText(
                            record.paymentNumber,
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
                              double.parse(record.amount),
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
                            'address',
                            color: color1,
                          ),
                          CustomText(
                            record.address.toUpperCase(),
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
                            record.coveredMonth.toUpperCase(),
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
                            record.date,
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
                            'phase',
                            color: color1,
                          ),
                          CustomText(
                            record.phase.split(',').first,
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
                            record.manager,
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
                    ],
                  ),
                ),
              );
            } else if (state is Officer) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          record.ownerName.toUpperCase(),
                          weight: FontWeight.bold,
                          color: color1,
                          size: 20,
                        ),
                      ),
                      addVerticalSpace(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            'payment number',
                            color: color1,
                          ),
                          CustomText(
                            record.paymentNumber,
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
                              double.parse(record.amount),
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
                            'address',
                            color: color1,
                          ),
                          CustomText(
                            record.address.toUpperCase(),
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
                            record.coveredMonth.toUpperCase(),
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
                            record.date,
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
                            'phase',
                            color: color1,
                          ),
                          CustomText(
                            record.phase.split(',').first,
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
                            record.manager,
                            color: color1,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else if (state is Collector) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          record.ownerName.toUpperCase(),
                          weight: FontWeight.bold,
                          color: color1,
                          size: 20,
                        ),
                      ),
                      addVerticalSpace(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            'payment number',
                            color: color1,
                          ),
                          CustomText(
                            record.paymentNumber,
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
                              double.parse(record.amount),
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
                            'address',
                            color: color1,
                          ),
                          CustomText(
                            record.address.toUpperCase(),
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
                            record.coveredMonth.toUpperCase(),
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
                            record.date,
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
                            'phase',
                            color: color1,
                          ),
                          CustomText(
                            record.phase.split(',').first,
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
                            record.manager,
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
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return HistoryDialog(house: record);
                                });
                          },
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider<HouseCubit>(
                                          create: (context) => sl<HouseCubit>(),
                                        ),
                                        BlocProvider<HistoryCubit>(
                                          create: (context) =>
                                              sl<HistoryCubit>(),
                                        ),
                                      ],
                                      child: UpdateDialog(
                                        uid: uid,
                                        house: record,
                                        username: state.user.username,
                                      ),
                                    ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: color3,
                              border: Border.all(color: color1, width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 40),
                              child: CustomBtnText(
                                'Update',
                                color: color1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is FirestoreUser) {
              String firstLetter = record.ownerName.characters.first;
              String lastLetter = record.ownerName.characters.last;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          '$firstLetter****$lastLetter'.toUpperCase(),
                          weight: FontWeight.bold,
                          color: color1,
                          size: 20,
                        ),
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
                              double.parse(record.amount),
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
                            'address',
                            color: color1,
                          ),
                          CustomText(
                            record.address.toUpperCase(),
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
                            record.coveredMonth.toUpperCase(),
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
                            record.date,
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
                            'phase',
                            color: color1,
                          ),
                          CustomText(
                            record.phase.split(',').first,
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
                            record.manager,
                            color: color1,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: color1,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
