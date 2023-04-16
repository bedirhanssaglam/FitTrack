import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fittrack/src/core/base/models/days_model.dart';
import 'package:fittrack/src/core/base/services/firebase_services.dart';

part 'training_event.dart';
part 'training_state.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  final FirebaseServices firebaseServices;
  TrainingBloc(this.firebaseServices) : super(TrainingInitial()) {
    on<FetchAllDays>(_onFetchAllDays);
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
}
