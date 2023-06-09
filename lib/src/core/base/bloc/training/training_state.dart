part of 'training_bloc.dart';

abstract class TrainingState extends Equatable {
  const TrainingState();

  @override
  List<Object> get props => [];
}

class TrainingInitial extends TrainingState {}

class DaysLoading extends TrainingState {}

class DaysLoaded extends TrainingState {
  final List<DaysModel> dayList;

  const DaysLoaded(this.dayList);

  @override
  List<Object> get props => [dayList];
}

class DaysError extends TrainingState {
  final String errorMessage;

  const DaysError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class TrainingByDayLoading extends TrainingState {}

class TrainingByDayLoaded extends TrainingState {
  final List<TrainingModel> trainingList;

  const TrainingByDayLoaded(this.trainingList);

  @override
  List<Object> get props => [trainingList];
}

class TrainingByDayError extends TrainingState {
  final String errorMessage;

  const TrainingByDayError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class TrainingAdding extends TrainingState {}

class TrainingAdded extends TrainingState {
  final bool isAdded;

  const TrainingAdded(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class TrainingError extends TrainingState {
  final String errorMessage;

  const TrainingError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class TrainingUpdating extends TrainingState {}

class TrainingUpdated extends TrainingState {
  final bool isUpdated;

  const TrainingUpdated(this.isUpdated);

  @override
  List<Object> get props => [isUpdated];
}

class TrainingUpdateError extends TrainingState {
  final String errorMessage;

  const TrainingUpdateError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class TrainingDeleting extends TrainingState {}

class TrainingDeleted extends TrainingState {
  final bool isDeleted;

  const TrainingDeleted(this.isDeleted);

  @override
  List<Object> get props => [isDeleted];
}

class TrainingDeleteError extends TrainingState {
  final String errorMessage;

  const TrainingDeleteError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
