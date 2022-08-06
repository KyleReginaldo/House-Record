import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:intl/intl.dart';

import '../../core/theme/colors.dart';

import '../../domain/entity/house_record_entity.dart';
import '../cubit/history/history_cubit.dart';
import '../cubit/house/house_cubit.dart';

class UpdateDialog extends StatefulWidget {
  final String username;
  final String uid;
  final HouseRecordEntity house;
  const UpdateDialog({
    Key? key,
    required this.username,
    required this.uid,
    required this.house,
  }) : super(key: key);

  @override
  State<UpdateDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<UpdateDialog> {
  final paymentNumber = TextEditingController();
  final date = TextEditingController();
  final owner = TextEditingController();
  final amount = TextEditingController();
  final coveredMonth = TextEditingController();
  final address = TextEditingController();
  final phase = TextEditingController();

  @override
  void initState() {
    date.text = DateFormat('dd/MMM/yyyy').format(DateTime.now());
    paymentNumber.text = widget.house.paymentNumber;
    owner.text = widget.house.ownerName;
    amount.text = widget.house.amount;
    coveredMonth.text = widget.house.coveredMonth;
    address.text = widget.house.address;
    phase.text = widget.house.phase.split(',').first;
    super.initState();
  }

  @override
  void dispose() {
    date.dispose();
    paymentNumber.dispose();
    owner.dispose();
    amount.dispose();
    coveredMonth.dispose();
    address.dispose();
    phase.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: color1,
      title: const CustomText(
        'UPDATE RECORD',
        letterSpacing: 3,
        textAlign: TextAlign.center,
        size: 15,
        color: color3,
        weight: FontWeight.w700,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'OR number',
            controller: paymentNumber,
            keyboard: TextInputType.number,
            color: color3,
            radius: 0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'date',
            controller: date,
            color: color3,
            radius: 0,
            suffix: IconButton(
              onPressed: () async {
                DateTime? datepicked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now());
                setState(() {
                  date.text = DateFormat('dd MMM yyyy')
                      .format(datepicked ?? DateTime.now());
                });
              },
              icon: const Icon(
                Icons.date_range_outlined,
                color: color3,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'owner',
            controller: owner,
            color: color3,
            radius: 0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'amount',
            controller: amount,
            keyboard: TextInputType.number,
            color: color3,
            radius: 0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'coveredMonth',
            controller: coveredMonth,
            color: color3,
            radius: 0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'address',
            controller: address,
            color: color3,
            radius: 0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'phase',
            controller: phase,
            color: color3,
            radius: 0,
            defaultData: phase.text,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                final house = HouseRecordEntity(
                  paymentNumber: paymentNumber.text,
                  date: date.text,
                  ownerName: owner.text,
                  amount: amount.text,
                  coveredMonth: coveredMonth.text,
                  address: address.text.toLowerCase(),
                  phase: phase.text.contains('2a')
                      ? '${phase.text.toLowerCase()},(${widget.username})'
                      : phase.text.toLowerCase(),
                  manager: FirebaseAuth.instance.currentUser?.email ?? '',
                );
                context.read<HistoryCubit>().addHistory(house);
                context.read<HouseCubit>().updateHouse(widget.uid, house);
                context.read<HouseCubit>();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: const Iconify(
                Ic.sharp_add_task,
                color: Colors.green,
                size: 30,
              ),
            ),
          ],
        )
      ],
    );
  }
}
