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
  final BuildContext context;

  const AddNewTraining(this.day, this.trainingName, this.time, this.context);

  @override
  List<Object> get props => [day, trainingName, time, context];
}

class UpdateTraining extends TrainingEvent {
  final String id;
  final String day;
  String? trainingName;
  String? time;
  final BuildContext context;

  UpdateTraining(this.id, this.day, this.trainingName, this.time, this.context);
}

class DeleteTraining extends TrainingEvent {}
