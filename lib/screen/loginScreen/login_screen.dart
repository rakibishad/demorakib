import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../../routes/router.dart';
import '../../routes/routes_name.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FluroRouters.router.navigateTo(
              context,
              RoutesName.dashboardUi,
              transition: TransitionType.fadeIn,
            );
          },
          child: const Text("Go to Dashboard"),
        ),
      ),
    );
  }
}
