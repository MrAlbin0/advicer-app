import 'package:advicer/domain/usecases/entities/advice_entities.dart';

class AdvicerModels extends AdviceEntities {
  AdvicerModels({required super.advice, required super.id});

  factory AdvicerModels.fromJson(Map<String, dynamic> json) {
    return AdvicerModels(advice: json["advice"], id: json["id"]);
  }
}
