import 'package:fit_track/src/core/constants/enums/route_enums.dart';
import 'package:fit_track/src/view/auth/login_view.dart';
import 'package:fit_track/src/view/home/home_view.dart';
import 'package:fit_track/src/view/workouts/add_workout_view.dart';
import 'package:fit_track/src/view/workouts/update_workout_view.dart';
import 'package:fit_track/src/view/workouts/workouts_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../view/auth/register_view.dart';
import '../../base/functions/base_functions.dart';

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
    initialLocation: RouteEnums.login.routeName,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
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
            route: const WorkoutsView(),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.updateWorkout.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRouting(
            state: state,
            route: UpdateWorkoutView(
              trainingName: state.params['trainingName']!,
            ),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.addWorkout.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRouting(
            state: state,
            route: const AddWorkOutView(),
          );
        },
      ),
    ],
  );
}
