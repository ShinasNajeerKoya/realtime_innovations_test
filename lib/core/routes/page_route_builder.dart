import 'package:flutter/material.dart';

enum TransitionType { fade, slideLeft, slideRight, scale, rotate }

PageRouteBuilder createPageRoute({
  required WidgetBuilder builder,
  required TransitionType transition,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transition) {
        case TransitionType.fade:
          return FadeTransition(
            opacity: animation,
            child: child,
          );

        case TransitionType.slideLeft:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0), // Slide from right to left
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );

        case TransitionType.slideRight:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0), // Slide from left to right
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );

        case TransitionType.scale:
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: child,
          );
        case TransitionType.rotate:
          return RotationTransition(
            turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: child,
          );
      }
    },
  );
}
