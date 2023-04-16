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

class AddNewTraining extends TrainingEvent {
  final String day;
  final String trainingName;
  final String time;

  const AddNewTraining(this.day, this.trainingName, this.time);

  @override
  List<Object> get props => [day, trainingName, time];
}
