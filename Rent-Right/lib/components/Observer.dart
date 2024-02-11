import 'package:flutter/material.dart';

class Observer extends NavigatorObserver {
  static final Observer _instance = Observer._internal();
  final List<String> _pages = [];

  Observer._internal();

  factory Observer() {
    return _instance;
  }

  List<String> get pages => _pages;

  @override
  void didPush(Route route, Route? previousRoute) {
    _pages.add(route.settings.name ?? '');
    print(_pages.toString());
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute == null) return;
    final index =
        _pages.indexWhere((element) => newRoute.settings.name == element);
    _pages[index] = newRoute.settings.name ?? '';
    print(_pages.toString());
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _pages.remove(route.settings.name ?? '');
    print(_pages.toString());
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _pages.remove(route.settings.name ?? '');
    print(_pages.toString());
  }
}
