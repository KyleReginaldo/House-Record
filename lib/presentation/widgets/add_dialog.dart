import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:intl/intl.dart';

import '../../core/theme/colors.dart';

import '../../domain/entity/house_record_entity.dart';
import '../cubit/house/house_cubit.dart';

class AddDialog extends StatefulWidget {
  final String username;
  const AddDialog({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final paymentNumber = TextEditingController();
  final date = TextEditingController();
  final owner = TextEditingController();
  final amount = TextEditingController();
  final coveredMonth = TextEditingController();
  final address = TextEditingController();
  final phase = TextEditingController();
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
  void initState() {
    date.text = DateFormat('dd/MMM/yyyy').format(DateTime.now());
    super.initState();
  }

  final orKey = GlobalKey<FormState>();
  final ownerKey = GlobalKey<FormState>();
  final amountKey = GlobalKey<FormState>();
  final coveredMonthKey = GlobalKey<FormState>();
  final addressKey = GlobalKey<FormState>();
  final phaseKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: color3,
      title: const CustomText(
        'ADD RECORD',
        letterSpacing: 3,
        textAlign: TextAlign.center,
        size: 15,
        color: color1,
        weight: FontWeight.w700,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'OR number',
            controller: paymentNumber,
            keyboard: TextInputType.number,
            color: color1,
            radius: 0,
            formKey: orKey,
            validator: (value) {
              if (value!.isEmpty) {
                return 'OR number is empty';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'date',
            controller: date,
            color: color1,
            radius: 0,
            suffix: IconButton(
              onPressed: () async {
                DateTime? datepicked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now());
                setState(() {
                  date.text = DateFormat('dd/MMM/yyyy')
                      .format(datepicked ?? DateTime.now());
                });
              },
              icon: const Icon(
                Icons.date_range_outlined,
                color: color1,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'owner',
            controller: owner,
            color: color1,
            radius: 0,
            formKey: ownerKey,
            validator: (value) {
              if (value!.isEmpty) {
                return 'owner field is empty';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'amount',
            controller: amount,
            keyboard: TextInputType.number,
            color: color1,
            formKey: amountKey,
            radius: 0,
            validator: (value) {
              if (value!.isEmpty) {
                return 'please input the amount';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'coveredMonth',
            controller: coveredMonth,
            color: color1,
            radius: 0,
            formKey: coveredMonthKey,
            validator: (value) {
              if (value!.isEmpty) {
                return 'covered month field is empty';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'address',
            controller: address,
            color: color1,
            radius: 0,
            formKey: addressKey,
            validator: (value) {
              if (value!.isEmpty) {
                return 'address field is empty';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          child: CustomTextField(
            'phase',
            controller: phase,
            color: color1,
            radius: 0,
            formKey: phaseKey,
            validator: (value) {
              if (value!.isEmpty) {
                return 'phase field requires a value';
              }
              return null;
            },
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
              onPressed: () async {
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
                  manager: FirebaseAuth.instance.currentUser?.email ?? 'na',
                );
                if (orKey.currentState!.validate() &&
                    ownerKey.currentState!.validate() &&
                    coveredMonthKey.currentState!.validate() &&
                    amountKey.currentState!.validate() &&
                    addressKey.currentState!.validate() &&
                    phaseKey.currentState!.validate()) {
                  Navigator.pop(context);
                  context.read<HouseCubit>().add(house);
                } else {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.red.shade300,
                      title: const CustomText('warning'),
                      content: const CustomText('Fields are empty'),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                          ),
                        ),
                      ],
                    ),
                  );
                }
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

  // Future<bool> callOnFcmApiSendPushNotifications(
  //     {required String title, required String body}) async {
  //   const postUrl = 'https://fcm.googleapis.com/fcm/send';
  //   final data = {
  //     "to": "/topics/myTopic",
  //     "notification": {
  //       "title": title,
  //       "body": body,
  //     },
  //     "data": {
  //       "type": '0rder',
  //       "id": '28',
  //       "click_action": 'FLUTTER_NOTIFICATION_CLICK',
  //     }
  //   };

  //   final headers = {
  //     'content-type': 'application/json',
  //     'Authorization':
  //         'key=AAAAiWsE8N0:APA91bH1eyEp7GRo-Lk2ZnLXRyyXh5w8fBIhW7bs3YUf9qFCTQO5JKNCPKRUiae5tVGOmqgawMHNrZGKUgQgAwVZT9Uf2Fptkw1wHf0CSiiYyj_hupb70R82bkUEnXiO9CPeCvuQT5eS' // 'key=YOUR_SERVER_KEY'
  //   };

  //   final response = await http.post(Uri.parse(postUrl),
  //       body: json.encode(data),
  //       encoding: Encoding.getByName('utf-8'),
  //       headers: headers);

  //   if (response.statusCode == 200) {
  //     // on success do sth
  //     print('test ok push CFM');
  //     return true;
  //   } else {
  //     print(' CFM error');
  //     // on failure do sth
  //     return false;
  //   }
  // }
}
