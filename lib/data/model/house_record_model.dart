// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:house_record/domain/entity/house_record_entity.dart';

part 'house_record_model.g.dart';

@HiveType(typeId: 5)
class HouseRecordModel extends HouseRecordEntity {
  HouseRecordModel({
    @HiveField(0) super.uid,
    @HiveField(1) required super.paymentNumber,
    @HiveField(2) required super.date,
    @HiveField(3) required super.ownerName,
    @HiveField(4) required super.amount,
    @HiveField(5) required super.coveredMonth,
    @HiveField(6) required super.address,
    @HiveField(7) required super.phase,
    @HiveField(8) required super.manager,
  });

  factory HouseRecordModel.fromMap(Map<String, dynamic> map) {
    return HouseRecordModel(
      uid: map['uid'],
      paymentNumber: map['paymentNumber'] ?? "",
      date: map['date'] ?? "",
      ownerName: map['ownerName'] ?? "",
      amount: map['amount'] ?? "",
      coveredMonth: map['coveredMonth'] ?? "",
      address: map['address'],
      phase: map['phase'],
      manager: map['manager'],
    );
  }
  factory HouseRecordModel.fromEntity(HouseRecordEntity house) {
    return HouseRecordModel(
      uid: house.uid,
      paymentNumber: house.paymentNumber,
      date: house.date,
      ownerName: house.ownerName,
      amount: house.amount,
      coveredMonth: house.coveredMonth,
      address: house.address,
      phase: house.phase,
      manager: house.manager,
    );
  }
  Map<String, dynamic> toMap() => {
        'uid': uid,
        'paymentNumber': paymentNumber,
        'date': date,
        'ownerName': ownerName,
        'amount': amount,
        'coveredMonth': coveredMonth,
        'address': address,
        'phase': phase,
        'manager': manager,
      };
}
