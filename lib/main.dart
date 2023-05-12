import 'dart:async';
import 'package:fittrack/src/core/base/singleton/base_singleton.dart';
import 'package:fittrack/src/core/init/app_initialize/app_initialize.dart';
import 'package:fittrack/src/core/init/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  await AppInitialize.appInit();
  runZoned(
    () => runApp(
      MultiRepositoryProvider(
        providers: DependencyInjector.instance.repositoryProviders,
        child: MultiBlocProvider(
          providers: DependencyInjector.instance.globalBlocProviders,
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget with BaseSingleton {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: constants.appName,
          routerConfig: routes.routes,
        );
      },
    );
  }
}
