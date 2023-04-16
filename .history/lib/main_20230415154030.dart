import 'package:firebase_core/firebase_core.dart';
import 'package:fittrack/src/core/base/singleton/base_singleton.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          title: 'Fit Track',
          theme: ThemeData(),
          routerConfig: routes.routes,
        );
      },
    );
  }
}
