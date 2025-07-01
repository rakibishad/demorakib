import 'package:fluro/fluro.dart';

import 'routes_handlers.dart';
import 'routes_name.dart';

import 'package:fluro/fluro.dart';
import 'routes_handlers.dart';
import 'routes_name.dart';

class FluroRouters {
  static final FluroRouter router = FluroRouter();

  static void setupRouter(FluroRouter router) {
    router.define(RoutesName.dashboardUi, handler: RouteHandlers.dashboardHandler);
    router.define(RoutesName.login, handler: RouteHandlers.loginHandler);
  }
}



