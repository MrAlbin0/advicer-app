import 'package:advicer/domain/failures/advice_failures.dart';
import 'package:advicer/domain/usecases/entities/advice_entities.dart';
import 'package:dartz/dartz.dart';



abstract class AdvicerReposetory {
  Future<Either<Failure, AdviceEntities>> getAdviceFromApi();
}
