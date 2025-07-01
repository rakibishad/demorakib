// 🟩 Core Flutter Packages
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rakibsk/screen/about_Screen/about_Ui.dart';
import 'package:rakibsk/screen/helpDesk/helpdesk_Ui.dart';


import 'package:rakibsk/screen/hosptal_Screen/hosptal_ui.dart';
import 'package:rakibsk/screen/listScreen/list_ui.dart';
import 'package:rakibsk/screen/registerstion_Screen/registation_ui.dart';
import 'package:rakibsk/screen/splashScreen/splashUi/splash_form.dart';
import 'package:rakibsk/screen/dashBoard_screen/dashboard_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appTheme/theme_Prefrences.dart';
import 'routes/routes_name.dart';

// 🌐 Network Check (Bloc)
import 'checkNetwork/network_bloc.dart';
import 'checkNetwork/network_event.dart';



void main() async {
  print('🚀 Starting from main_prod.dart');

  WidgetsFlutterBinding.ensureInitialized();

  // ✅ SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('user_token');
  print("✅ Stored token is: $token");

  // ✅ Firebase Initialization
  try {
    await Firebase.initializeApp();
    debugPrint("✅ Firebase initialized successfully");
  } catch (e) {
    debugPrint("❌ Firebase initialization failed: $e");
  }

  // ✅ Create ThemeRepository
  final themeRepository = ThemeRepository(sharedPreferences: prefs);

  // ✅ Run the app
  runApp(
    BlocProvider(
      create: (context) => NetworkBloc()..add(ListenConnection()),
      child: MyApp(themeRepository: themeRepository), // 🔥 Required param passed correctly
    ),
  );
}


class MyApp extends StatelessWidget {

  final ThemeRepository themeRepository;
  const MyApp({required this.themeRepository, super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hospital Info App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      initialRoute: RoutesName.splashscreen,
      getPages: [
        GetPage(
          name: RoutesName.splashscreen,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: RoutesName.dashboardUi,
          page: () => const DashboardUi(),
        ),
        GetPage(
          name: RoutesName.hosptalUi,
          page: () => const HosptalUi(),
        ),
        GetPage(
          name: RoutesName.listscrren,
          page: () => const UserListScreen(),
        ),
        GetPage(
          name: RoutesName.registation,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: RoutesName.about,
          page: () => AboutUi(),
        ),
        GetPage(
          name: RoutesName.helpdesk,
          page: () => HelpdeskUi(),
        ),
      ],
    );
  }
}
