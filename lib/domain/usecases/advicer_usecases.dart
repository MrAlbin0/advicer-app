import 'package:advicer/domain/failures/advice_failures.dart';
import 'package:advicer/domain/usecases/entities/advice_entities.dart';
import 'package:advicer/domain/usecases/reposetories/advicer_reposetory.dart';
import 'package:dartz/dartz.dart';

class AdvicerUsecases {
  final AdvicerReposetory advicerReposetory;

  AdvicerUsecases({required this.advicerReposetory});

  Future<Either<Failure, AdviceEntities>> getAdviceUsecase() async {
    return await advicerReposetory.getAdviceFromApi();
  }
}
