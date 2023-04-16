import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fittrack/src/core/base/models/days_model.dart';
import 'package:fittrack/src/core/base/services/firebase_services.dart';
import 'package:fittrack/src/core/components/snackbar/snackbar.dart';
import 'package:fittrack/src/view/workouts/add_workout_view.dart';
import 'package:flutter/material.dart';

part 'training_event.dart';
part 'training_state.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  final FirebaseServices firebaseServices;
  TrainingBloc(this.firebaseServices) : super(TrainingInitial()) {
    on<FetchAllDays>(_onFetchAllDays);
    on<FetchTrainingsByDay>(_onFetchTrainingsByDay);
    on<AddNewTraining>(_onAddNewTraining);
  }

  Future<void> _onFetchAllDays(
      FetchAllDays event, Emitter<TrainingState> emit) async {
    try {
      emit(DaysLoading());
      List<DaysModel> dayList = await firebaseServices.getDays();
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
      snackbarWidget(
        event.context,
        message: "Training was added",
      );
    } catch (e) {
      emit(TrainingError(e.toString()));
      snackbarWidget(
        event.context,
        message: "Training was added",
      );
    }
  }
}
