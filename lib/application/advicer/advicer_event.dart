part of 'advicer_bloc.dart';

@immutable
sealed class AdvicerEvent {}

/// event when button is pressed
class AdviceRequestedEvent extends AdvicerEvent {}

class ExampleEvent extends AdvicerEvent {}