//import 'package:advicer/application/advicer/advicer_bloc.dart';
import 'package:advicer/domain/failures/advice_failures.dart';
import 'package:advicer/domain/usecases/entities/advice_entities.dart';
import 'package:dartz/dartz.dart';

class AdvicerUsecases {
  Future sleep1() {
    return Future.delayed(Duration(seconds: 2), () => "0");
  }

  Future<Either<Failure, AdviceEntities>> getAdviceUsecase() async {
    await sleep1();

    return Left(GeneralFailure());

    //return Right(AdviceEntities(advice: "example", id: 1));
  }
}
