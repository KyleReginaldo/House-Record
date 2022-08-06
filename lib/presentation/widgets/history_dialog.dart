import 'package:flutter/material.dart';
import 'package:general/widgets/divider.dart';
import 'package:general/widgets/text.dart';
import 'package:house_record/domain/entity/house_record_entity.dart';
import 'package:intl/intl.dart';

import '../../core/theme/colors.dart';
import '../../core/utils/helper_widget.dart';

class HistoryDialog extends StatelessWidget {
  final HouseRecordEntity house;
  const HistoryDialog({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Dialog(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: CustomText(
                house.ownerName.toUpperCase(),
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
                  house.paymentNumber,
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
                          locale: 'fil', symbol: '₱', decimalDigits: 2)
                      .format(
                    double.parse(house.amount),
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
                  house.address.toUpperCase(),
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
                  house.coveredMonth.toUpperCase(),
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
                  house.date,
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
                  house.phase.split(',').first,
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
                  house.manager,
                  color: color1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
