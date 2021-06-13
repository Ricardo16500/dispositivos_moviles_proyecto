import 'package:flutter/cupertino.dart';
class SizeRoute extends PageRouteBuilder {
  final Widget page;
  SizeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        ),
  );
}
class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page}):
        super(
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            ) =>
        page,
        transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
            ) =>
            ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child,
            ),
      );
}
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) => page,

    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) => FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
class SlideRoute extends PageRouteBuilder {
  final Widget page;
  SlideRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        //) => page,
        ) {
      return page;
    },

    transitionDuration: Duration(milliseconds: 2000),

    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>  SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    ),
  );
}
class RotationRoute extends PageRouteBuilder {
  final Widget page;
  RotationRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionDuration: Duration(milliseconds:1500 ),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        RotationTransition(
          turns: Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            ),
          ),
          child: child,
        ),
  );
}