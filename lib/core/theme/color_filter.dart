import 'package:flutter/material.dart';
import 'package:house_record/domain/entity/house_record_entity.dart';

Color alternateColor(List length, HouseRecordEntity e) {
  final indexs = length.indexOf(e).isEven;
  final color = indexs ? Colors.grey.shade800 : Colors.black;
  return color;
}
