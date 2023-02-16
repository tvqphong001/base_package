import '../../base.dart';

mixin RouteListener<T extends StatefulWidget> on State<T> {
  late RouteAware routeAware;

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  void didPopNext() {}

  /// Called when the current route has been pushed.
  void didPush() {}

  /// Called when the current route has been popped off.
  void didPop() {}

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  void didPushNext() {}

  @override
  void initState() {
    routeAware = MyRoute(pop: didPop,popNext: didPopNext,push: didPush,pushNext: didPushNext);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(routeAware, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(routeAware);

    super.dispose();
  }
}

class MyRoute extends RouteAware {
  final VoidCallback popNext;
  final VoidCallback push;
  final VoidCallback pop;
  final VoidCallback pushNext;

  MyRoute({required this.push,required this.pop,required this.pushNext,required this.popNext});

  @override
  void didPopNext() {
    popNext();
    super.didPopNext();
  }

  /// Called when the current route has been pushed.
  @override
  void didPush() {
    push();
    super.didPush();
  }

  /// Called when the current route has been popped off.
  @override
  void didPop() {
    pop();
    super.didPop();
  }

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  @override
  void didPushNext() {
    pushNext();
    super.didPushNext();
  }
}