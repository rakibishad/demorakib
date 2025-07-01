import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../screen/dashBoard_screen/dashboard_ui.dart';
import '../screen/loginScreen/login_screen.dart';

class RouteHandlers {
  static final Handler dashboardHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const DashboardUi(); // DashboardUi should be a widget
    },
  );

  static final Handler loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const LoginScreen(); // LoginScreen should be a widget
    },
  );
}
