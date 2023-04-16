import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:fittrack/src/core/base/services/i_firebase_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../init/cache/cache_manager.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IFirebaseServices firebaseServices;

  AuthBloc(this.firebaseServices) : super(const AuthState.unknown()) {
    on<AppStarted>((event, emit) async {
      try {
        if (await firebaseServices.isLoggedIn()) {
          await authService.updateTokenFromStorage();
          emit(const AuthState.authenticated());
        } else {
          emit((await authService.isFirstEntry())
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
        final response = await authService.login(
            email: event.email, password: event.password);
        await authService.updateToken(response.data?.id);
        await authService.updateLoggedIn(true);

        await CacheManager.setString("uyeID", response.data!.id!);
        var box = await Hive.openBox("profile");
        box.put("ad", response.data!.ad);
        print('${response.data!.ad}//');
        box.put("soyad", response.data!.soyad);
        print('${response.data!.soyad}////');
        box.put("email", response.data!.email);
        print('${response.data!.email}/***');
        box.put("telefon", response.data!.telefon);
        print('${response.data!.telefon}/---');
        box.put("avatar", response.data!.avatar);
        print('${response.data!.avatar}/+++');
        print(response.sonuc);
        print("////////////////");

        if (response.data != null) {
          emit(const AuthState.authenticated());
        } else if (response.sonuc ==
            "No Member Found in the Information You Entered") {
          add(const LogoutRequested());
          emit(AuthState.error(error: AuthError.wrongEmailOrPassword));
        }
      },
    );

    on<StoreLoginRequested>(
      (event, emit) async {
        final response = await authService.storeLogin(
            email: event.email, password: event.password);
        await authService.updateToken(response.data?.id);
        await authService.updateLoggedIn(true);

        await CacheManager.setString("uyeID", response.data!.id!);

        if (response.data != null) {
          var box = Hive.box("profile");
          box.put("ad", response.data!.ad);
          box.put("soyad", response.data!.soyad);
          box.put("email", response.data!.email);
          box.put("telefon", response.data!.telefon);
          emit(const AuthState.authenticated());
        } else {
          emit(AuthState.error(error: AuthError.wrongEmailOrPassword));
        }
      },
    );
    on<LogoutRequested>((event, emit) {
      authService.signOut();
      emit(const AuthState.guest());
    });
  }
}
