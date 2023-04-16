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
