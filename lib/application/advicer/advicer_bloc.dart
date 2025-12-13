import 'package:advicer/domain/failures/advice_failures.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:advicer/domain/usecases/entities/advice_entities.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  final AdvicerUsecases usecases;

  AdvicerBloc({required this.usecases}) : super(AdvicerInitial()) {
    on<AdviceRequestedEvent>((event, emit) async {
      emit(AdvicerStateLoading());

      final Either<Failure, AdviceEntities> adviceOrFailure = await usecases
          .getAdviceUsecase();

      adviceOrFailure.fold(
        (failure) => emit(AdvicerStateError(message: _mapFailureToMessage(failure))),
        (advice) => emit(AdvicerStateLoaded(advice: advice.advice)),
      );
    });

    on<ExampleEvent>((event, emit) {});
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Ups, API error. Please try again!";

      case GeneralFailure:
        return "Ups, Something went wrong. Please try again!";

      default:
        return "Ups, Something went wrong. Please try again!";
    }
  }
}
