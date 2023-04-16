import 'package:fittrack/src/core/base/models/training_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../view/auth/login_view.dart';
import '../../../view/auth/register_view.dart';
import '../../../view/home/home_view.dart';
import '../../../view/splash/splash_view.dart';
import '../../../view/workouts/add_workout_view.dart';
import '../../../view/workouts/update_workout_view.dart';
import '../../../view/workouts/workouts_view.dart';
import '../../base/functions/base_functions.dart';
import '../../constants/enums/route_enums.dart';

final GlobalKey<NavigatorState> mainNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'main');

class Routes {
  static Routes? _instance;
  static Routes get instance {
    _instance ??= Routes._init();
    return _instance!;
  }

  Routes._init();

  GoRouter routes = GoRouter(
    navigatorKey: mainNavigatorKey,
    initialLocation: RouteEnums.splash.routeName,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: RouteEnums.splash.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRouting(
            state: state,
            route: const SplashView(),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.login.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRouting(
            state: state,
            route: const LoginView(),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.register.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRouting(
            state: state,
            route: const RegisterView(),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.home.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRouting(
            state: state,
            route: const HomeView(),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.workouts.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRouting(
            state: state,
            route: WorkoutsView(
              day: state.params['day']!,
            ),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.updateWorkout.routeName,
        pageBuilder: (context, state) {
          final Map<String, Object?>? params =
              state.extra as Map<String, Object?>?;
          return BaseFunctions.instance.animatedRouting(
            state: state,
            route: UpdateWorkoutView(
              day: state.params['day']!,
              trainingModel: (params?["trainingModel"] as TrainingModel),
            ),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.addWorkout.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRouting(
            state: state,
            route: AddWorkOutView(
              day: state.params['day']!,
            ),
          );
        },
      ),
    ],
  );
}
