import 'package:fittrack/src/core/base/bloc/auth/auth_bloc.dart';
import 'package:fittrack/src/core/base/services/firebase_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/bloc/training/training_bloc.dart';
import '../../base/services/i_firebase_services.dart';

class DependencyInjector {
  static DependencyInjector? _instance;

  static DependencyInjector get instance {
    _instance ??= DependencyInjector._init();
    return _instance!;
  }

  late final IFirebaseServices firebaseServices;
  late final TrainingBloc trainingBloc;
  late final AuthBloc authBloc;

  DependencyInjector._init() {
    firebaseServices = FirebaseServices();
    trainingBloc = TrainingBloc(firebaseServices);
    authBloc = AuthBloc(firebaseServices);
  }

  List<RepositoryProvider> get repositoryProviders => [
        RepositoryProvider<IFirebaseServices>(
            create: (context) => firebaseServices),
      ];

  List<BlocProvider<Bloc>> get globalBlocProviders => [
        BlocProvider<TrainingBloc>(create: (context) => trainingBloc),
        BlocProvider<AuthBloc>(create: (context) => authBloc),
      ];
}
