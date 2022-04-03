import 'package:flutter/material.dart';
import '../home_page.dart';
import '../main.dart';

///Routing with defined name
class CsiRoute {
  static const routeMain = '/';
  static const routeHome = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeMain:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case routeHome:
        return MaterialPageRoute(builder: (_) => const HomePage());


      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}
