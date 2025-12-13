import 'package:advicer/domain/failures/advice_failures.dart';
import 'package:advicer/domain/usecases/entities/advice_entities.dart';
import 'package:advicer/domain/usecases/reposetories/advicer_reposetory.dart';
import 'package:advicer/infrastructure/exceptions/exceptions.dart';
import 'package:advicer/infrastructure/repositories/datasources/advicer_remote_datasources.dart';
import 'package:dartz/dartz.dart';

class AdvicerRepositorysImpl implements AdvicerReposetory {
  final AdvicerRemoteDatasources advicerRemoteDatasources;

  AdvicerRepositorysImpl({required this.advicerRemoteDatasources});

  @override
  Future<Either<Failure, AdviceEntities>> getAdviceFromApi() async {
    try {
      final remoteAdvice = await advicerRemoteDatasources
          .getRandomAdviceFromApi();
      return Right(remoteAdvice);
    } catch (exception) {
      if (exception.runtimeType is ServerException) {
        return Left(ServerFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }
}
