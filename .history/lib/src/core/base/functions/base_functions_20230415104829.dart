import 'dart:core';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseFunctions {
  static BaseFunctions? _instance;
  static BaseFunctions get instance {
    _instance ??= BaseFunctions._init();
    return _instance!;
  }

  BaseFunctions._init();

  animatedRouting({
    required GoRouterState state,
    required Widget route,
  }) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: route,
        transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) =>
            SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: child,
        ),
      );
}
