import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppPageRoute extends MaterialPageRoute<String> {
  @override
  final bool maintainState;

  @override
  final WidgetBuilder builder;
  CupertinoPageRoute<String> _internalCupertinoPageRoute;

  AppPageRoute({
    @required this.builder,
    RouteSettings settings: const RouteSettings(),
    this.maintainState: true,
    bool fullscreenDialog: false,
  })  : assert(builder != null),
        assert(settings != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        super(
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        builder: builder,
      ) {
    assert(opaque); // PageRoute makes it return true.
  }

  @override
  Color get barrierColor => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  CupertinoPageRoute<String> get _cupertinoPageRoute {
    assert(_useCupertinoTransitions);
    _internalCupertinoPageRoute ??= new CupertinoPageRoute<String>(
      builder: builder,
      fullscreenDialog: fullscreenDialog,
    );
    return _internalCupertinoPageRoute;
  }

  bool get _useCupertinoTransitions {
    return _internalCupertinoPageRoute?.popGestureInProgress == true ||
        Theme.of(navigator.context).platform == TargetPlatform.iOS;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final Widget result = builder(context);
    assert(() {
      if (result == null) {
        throw new FlutterError('The builder for route "${settings.name}" returned null.\n'
            'Route builders must never return null.');
      }
      return true;
    }());
    return result;
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (_useCupertinoTransitions) {
      return _cupertinoPageRoute.buildTransitions(context, animation, secondaryAnimation, child);
    }
    return new ZoomPageTransitionsBuilder().buildTransitions(null, context, animation, secondaryAnimation, child);
  }
}
