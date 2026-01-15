import 'package:advicer/domain/failures/advice_failures.dart';
import 'package:advicer/domain/usecases/reposetories/advicer_reposetory.dart';
import 'package:advicer/infrastructure/exceptions/exceptions.dart';
import 'package:advicer/infrastructure/repositories/advicer_repositorys_impl.dart';
import 'package:advicer/infrastructure/repositories/datasources/advicer_remote_datasources.dart';
import 'package:advicer/infrastructure/repositories/models/advicer_models.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'advicer_repository_test.mocks.dart';

@GenerateMocks([AdvicerRemoteDatasources])
void main() {
  late AdvicerReposetory advicerReposetory;
  late MockAdvicerRemoteDatasources mockAdvicerRemoteDatasources;

  setUp(() {
    mockAdvicerRemoteDatasources = MockAdvicerRemoteDatasources();
    advicerReposetory = AdvicerRepositorysImpl(
    advicerRemoteDatasources: mockAdvicerRemoteDatasources,
    );
  });


  group("getAdviceFromApi", () {
    final t_advicerModel = AdvicerModels(advice: "test", id: 1);
    final t_advice = t_advicerModel; 

    test("should return remote data", () async {
      //arrange

      when(mockAdvicerRemoteDatasources.getRandomAdviceFromApi()).thenAnswer((_) async => t_advicerModel);

      //act

      final result = await advicerReposetory.getAdviceFromApi();

      //assert

      verify(mockAdvicerRemoteDatasources.getRandomAdviceFromApi());
      verifyNoMoreInteractions(mockAdvicerRemoteDatasources);
      expect(result, Right(t_advice));
    
    });


    test("should return server failure", () async {
    //arrange

    when(mockAdvicerRemoteDatasources.getRandomAdviceFromApi()).thenThrow(ServerException());

    //act

    final result = await advicerReposetory.getAdviceFromApi();

    //assert

    verify(mockAdvicerRemoteDatasources.getRandomAdviceFromApi());
    verifyNoMoreInteractions(mockAdvicerRemoteDatasources);
    expect(result, Left(ServerFailure()));

    });


  });
}
