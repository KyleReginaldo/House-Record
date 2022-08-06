import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';

import '../../core/theme/colors.dart';

import '../cubit/getusercubit/getuser_cubit.dart';

class UpdateUserDialog extends StatefulWidget {
  final String email;
  final String role;
  const UpdateUserDialog({
    Key? key,
    required this.email,
    required this.role,
  }) : super(key: key);

  @override
  State<UpdateUserDialog> createState() => _UpdateUserDialogState();
}

class _UpdateUserDialogState extends State<UpdateUserDialog> {
  @override
  void initState() {
    roleController.text = widget.role;
    super.initState();
  }

  final roleController = TextEditingController();
  List<String> roles = ['officer', 'collector', 'user'];
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            roleController.text,
            controller: roleController,
            color: color1,
            suffix: PopupMenuButton(
              icon: const Iconify(
                Carbon.user_role,
                color: color3,
              ),
              itemBuilder: (context) => roles
                  .map(
                    (e) => PopupMenuItem(
                      textStyle: const TextStyle(color: color1),
                      value: e,
                      child: CustomText(e),
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                setState(() {
                  roleController.text = value.toString();
                });
              },
            ),
          ),
        ),
        BtnTextOnly(
          onTap: () async {
            if (roleController.text.isNotEmpty) {
              context.read<GetuserCubit>().getUserAccounts();
              Navigator.pop(context);
              final userDoc = FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.email);
              await userDoc.update({'role': roleController.text});
            }
          },
          text: 'update role',
        )
      ],
    );
  }
}
