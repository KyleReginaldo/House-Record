import 'package:hive/hive.dart';
import '../../domain/entity/suggestion_entity.dart';

part 'suggestion_model.g.dart';

@HiveType(typeId: 0)
class SuggestionModel extends SuggestionEntity {
  @override
  SuggestionModel({@HiveField(0) required super.address});
  factory SuggestionModel.fromEntity(SuggestionEntity entity) {
    return SuggestionModel(address: entity.address);
  }
}
