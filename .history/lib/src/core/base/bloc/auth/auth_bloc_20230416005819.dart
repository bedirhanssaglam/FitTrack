import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:fittrack/src/core/base/services/i_firebase_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/enums/auth_error.dart';
import '../../../constants/enums/auth_status.dart';
import '../../../init/cache/cache_manager.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IFirebaseServices firebaseServices;

  AuthBloc(this.firebaseServices) : super(const AuthState.unknown()) {
    on<AppStarted>((event, emit) async {
      try {
        if (await firebaseServices.isLoggedIn()) {
          await firebaseServices.updateTokenFromStorage();
          emit(const AuthState.authenticated());
        } else {
          emit((await firebaseServices.isFirstEntry())
              ? const AuthState.firstEntry()
              : const AuthState.guest());
        }
      } on SocketException {
        emit(AuthState.error(error: AuthError.hostUnreachable));
      } catch (e) {
        if (e.toString() ==
            "The consumer isn't authorized to access %resources.") {
          add(const LogoutRequested());
        }
        if (kDebugMode) {
          print(e);
        }
        emit(AuthState.error());
      }
    });

    on<LoginRequested>(
      (event, emit) async {
        final response = await firebaseServices.login(
            email: event.email, password: event.password);
        await firebaseServices.updateLoggedIn(true);
        if (response != null) {
          emit(const AuthState.authenticated());
        } else {
          add(const LogoutRequested());
          emit(AuthState.error(error: AuthError.wrongEmailOrPassword));
        }
      },
    );

    on<RegisterRequested>(
      (event, emit) async {
        final response = await firebaseServices.register(
          name: event.email,
          email: event.email,
          password: event.password,
        );
        await firebaseServices.updateLoggedIn(true);
        if (response != null) {
          emit(const AuthState.authenticated());
        } else {
          emit(AuthState.error(error: AuthError.wrongEmailOrPassword));
        }
      },
    );

    on<LogoutRequested>((event, emit) {
      firebaseServices.signOut();
      emit(const AuthState.guest());
    });
  }
}
