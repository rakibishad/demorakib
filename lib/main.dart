// 🟩 Core Flutter Packages
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rakibsk/phoneAuth/loginMobile_ui.dart';
import 'package:rakibsk/phoneAuth/otpverifaction.dart';
import 'package:rakibsk/screen/about_Screen/about_Ui.dart';
import 'package:rakibsk/screen/about_Screen/setting_screen.dart';
import 'package:rakibsk/screen/dashBoard_screen/dasbord_cubit.dart';
import 'package:rakibsk/screen/helpDesk/helpdesk_Ui.dart';
import 'package:rakibsk/screen/hosptal_Screen/hosptal_ui.dart';
import 'package:rakibsk/screen/invoiceScreens/api/data.dart';
import 'package:rakibsk/screen/invoiceScreens/cubits/invoice_cubit.dart';
import 'package:rakibsk/screen/invoiceScreens/invoice_screen.dart';
import 'package:rakibsk/screen/listScreen/list_ui.dart';
import 'package:rakibsk/screen/liveChats/live_chat.dart';
import 'package:rakibsk/screen/locationScreens/CityAreaSelectionScreen.dart';
import 'package:rakibsk/screen/loginScreen/login_screen.dart';
import 'package:rakibsk/screen/pdfdownload/pdf_Ui.dart';
import 'package:rakibsk/screen/searchfilters/search_filter_screen.dart';
import 'package:rakibsk/screen/splashScreen/splashUi/splash_form.dart';
import 'package:rakibsk/screen/dashBoard_screen/dashboard_ui.dart';
import 'package:rakibsk/screen/webView/attendenceScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PhoneAuthScreen.dart';
import 'appTheme/theme_Prefrences.dart';
import 'routes/routes_name.dart';

// 🌐 Network Check (Bloc)
import 'checkNetwork/network_bloc.dart';
import 'checkNetwork/network_event.dart';

import 'firebase_options.dart';

void main() async {
  print('🚀 Starting from main.dart');

  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Shared Preferences
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('user_token');
  print("✅ Stored token is: $token");

  // ✅ Firebase Initialization
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity, // Use debug for testing
    );
    debugPrint("✅ Firebase initialized");

    // ✅ Firebase App Check (Dev Mode)
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );
  } catch (e) {
    debugPrint("❌ Firebase init failed: $e");
  }

  final themeRepository = ThemeRepository(sharedPreferences: prefs);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NetworkBloc>(
          create: (_) => NetworkBloc()..add(ListenConnection()),
        ),
        BlocProvider<InvoiceCubit>(
          create: (_) => InvoiceCubit(InvoiceRepository()),
        ),
        BlocProvider<DashboardCubit>( // 🔥 Add this line
          create: (_) => DashboardCubit(),
        ),
      ],
      child: MyApp(themeRepository: themeRepository),
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
          name: RoutesName.login,
          page: () => LoginScreen(),
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
        GetPage(
          name: RoutesName.mobileauth,
          page: () => LoginMobileUi(),
        ),
        GetPage(
          name: RoutesName.otpScreen, // ✅ THIS IS REQUIRED
          page: () => OtpScreen(),
        ),
        GetPage(
          name: RoutesName.setting, // ✅ THIS IS REQUIRED
          page: () => SettingsScreen(),
        ),
        GetPage(
          name: RoutesName.livechat, // ✅ THIS IS REQUIRED
          page: () =>MessagingScreen (),
        ),
        GetPage(
          name: RoutesName.invoice, // ✅ THIS IS REQUIRED
          page: () =>InvoiceScreen (),
        ),
        GetPage(
          name: RoutesName.cityarea, // ✅ THIS IS REQUIRED
          page: () =>CityAreaSelectionScreen (),
        ), GetPage(
          name: RoutesName.searchfilter, // ✅ THIS IS REQUIRED
          page: () =>SearchFilterScreen (),
        ),
        GetPage(
          name: RoutesName.mobileotp, // ✅ THIS IS REQUIRED
          page: () =>PhoneAuthScreen (),
        ), GetPage(
          name: RoutesName.webviewattendence, // ✅ THIS IS REQUIRED
          page: () =>WebViewScreen (),
        ),
        GetPage(
          name: RoutesName.Pdfdownload, // ✅ THIS IS REQUIRED
          page: () =>PdfUi (),
        ),
      ],
    );
  }
}
