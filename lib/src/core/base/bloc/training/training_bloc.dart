import 'dart:async';

import 'package:fittrack/src/core/constants/app/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fittrack/src/core/base/models/days_model.dart';
import 'package:fittrack/src/core/components/snackbar/snackbar.dart';
import 'package:flutter/material.dart';

import '../../models/training_model.dart';
import '../../services/i_firebase_services.dart';

part 'training_event.dart';
part 'training_state.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  final IFirebaseServices firebaseServices;
  TrainingBloc(this.firebaseServices) : super(TrainingInitial()) {
    on<FetchAllDays>(_onFetchAllDays);
    on<FetchTrainingsByDay>(_onFetchTrainingsByDay);
    on<AddNewTraining>(_onAddNewTraining);
    on<UpdateTraining>(_onUpdateTraining);
    on<DeleteTraining>(_onDeleteTraining);
  }

  Future<void> _onFetchAllDays(
      FetchAllDays event, Emitter<TrainingState> emit) async {
    try {
      emit(DaysLoading());
      List<DaysModel> dayList = await firebaseServices.fetchAllDays();
      emit(DaysLoaded(dayList));
    } catch (e) {
      emit(DaysError(e.toString()));
    }
  }

  Future<void> _onFetchTrainingsByDay(
      FetchTrainingsByDay event, Emitter<TrainingState> emit) async {
    try {
      emit(TrainingByDayLoading());
      List<TrainingModel> trainingList =
          await firebaseServices.getTrainingByDay(day: event.day);
      emit(TrainingByDayLoaded(trainingList));
    } catch (e) {
      emit(TrainingByDayError(e.toString()));
    }
  }

  Future<void> _onAddNewTraining(
      AddNewTraining event, Emitter<TrainingState> emit) async {
    try {
      emit(TrainingAdding());
      bool isAdded = await firebaseServices.createTraining(
        day: event.day,
        trainingName: event.trainingName,
        time: event.time,
      );
      emit(TrainingAdded(isAdded));
      SnackbarUtil.snackbarWidget(
        event.context,
        message: AppConstants.instance.trainingAdded,
      );
    } catch (e) {
      emit(TrainingError(e.toString()));
      SnackbarUtil.snackbarWidget(
        event.context,
        message: AppConstants.instance.trainingNotAdded,
        isSuccess: false,
      );
    }
  }

  Future<void> _onUpdateTraining(
      UpdateTraining event, Emitter<TrainingState> emit) async {
    try {
      emit(TrainingUpdating());
      bool isUpdated = await firebaseServices.updateTraining(
        id: event.id,
        day: event.day,
        trainingName: event.trainingName,
        time: event.time,
      );
      emit(TrainingUpdated(isUpdated));
      SnackbarUtil.snackbarWidget(event.context,
          message: AppConstants.instance.trainingUpdated);
    } catch (e) {
      emit(TrainingUpdateError(e.toString()));
      SnackbarUtil.snackbarWidget(
        event.context,
        message: AppConstants.instance.trainingNotUpdated,
        isSuccess: false,
      );
    }
  }

  Future<void> _onDeleteTraining(
      DeleteTraining event, Emitter<TrainingState> emit) async {
    try {
      emit(TrainingDeleting());
      bool isDeleted =
          await firebaseServices.deleteTraining(id: event.id, day: event.day);
      emit(TrainingDeleted(isDeleted));
      SnackbarUtil.snackbarWidget(event.context, message: "Training deleted.");
    } catch (e) {
      emit(TrainingDeleteError(e.toString()));
      SnackbarUtil.snackbarWidget(
        event.context,
        message: "Failed to delete training.",
        isSuccess: false,
      );
    }
  }
}
