import 'package:fittrack/src/core/base/bloc/training_bloc.dart';
import 'package:fittrack/src/core/base/services/firebase_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/services/i_firebase_services.dart';

class DependencyInjector {
  static DependencyInjector? _instance;

  static DependencyInjector get instance {
    _instance ??= DependencyInjector._init();
    return _instance!;
  }

  late final IFirebaseServices firebaseServices;
  late final TrainingBloc trainingBloc;

  DependencyInjector._init() {
    firebaseServices = FirebaseServices();
    trainingBloc = TrainingBloc(firebaseServices);
  }

  List<RepositoryProvider> get repositoryProviders => [
        RepositoryProvider<IFirebaseServices>(
            create: (context) => firebaseServices),
      ];

  List<BlocProvider<Bloc>> get globalBlocProviders => [
        BlocProvider<TrainingBloc>(create: (context) => trainingBloc),
      ];
}
