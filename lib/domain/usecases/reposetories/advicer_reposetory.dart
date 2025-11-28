

import 'package:advicer/domain/usecases/entities/advice_entities.dart';

abstract class AdvicerReposetory {
  Future<AdviceEntities> getAdviceFromApi();
}