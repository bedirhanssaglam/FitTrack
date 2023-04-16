part of 'training_bloc.dart';

abstract class TrainingEvent extends Equatable {
  const TrainingEvent();

  @override
  List<Object> get props => [];
}

class FetchAllDays extends TrainingEvent {}

class FetchTrainingsByDay extends TrainingEvent {
  final String day;

  const FetchTrainingsByDay(this.day);

  @override
  List<Object> get props => [day];
}
