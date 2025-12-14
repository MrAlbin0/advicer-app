import 'package:advicer/domain/failures/advice_failures.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:advicer/domain/usecases/entities/advice_entities.dart';
import 'package:advicer/domain/usecases/reposetories/advicer_reposetory.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'advicer_usecases_test.mocks.dart';

@GenerateMocks([AdvicerReposetory])
void main() {
  late AdvicerUsecases advicerUsecases;
  late MockAdvicerReposetory mockAdvicerReposetory;

  setUp(() {
    mockAdvicerReposetory = MockAdvicerReposetory();
    advicerUsecases = AdvicerUsecases(advicerReposetory: mockAdvicerReposetory);
  });

  group("getAdviceUsecase", () {
    final testAdvice = AdviceEntities(advice: "test", id: 1);

    test("should return the same advice as repo", () async {
      //arrange

      when(
        mockAdvicerReposetory.getAdviceFromApi(),
      ).thenAnswer((_) async => Right(testAdvice));

      //act

      final result = await advicerUsecases.getAdviceUsecase();

      //assert

      expect(result, Right(testAdvice));
      verify(mockAdvicerReposetory.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdvicerReposetory);
    });

    test("should return the same serverFailure as repo", () async {
      //arange

      when(
        mockAdvicerReposetory.getAdviceFromApi(),
      ).thenAnswer((_) async => Left(ServerFailure()));

      //act

      final result = await advicerUsecases.getAdviceUsecase();

      //assert

      expect(result, Left(ServerFailure()));
    });

    test("should return the same generalFailure as repo", () async {
      //arrange

      when(
        mockAdvicerReposetory.getAdviceFromApi(),
      ).thenAnswer((_) async => Left(GeneralFailure()));

      //act

      final result = await advicerUsecases.getAdviceUsecase();

      //assert

      expect(result, Left(GeneralFailure()));
    });
  });
}
