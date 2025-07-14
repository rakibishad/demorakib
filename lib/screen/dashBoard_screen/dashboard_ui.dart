import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakibsk/screen/about_Screen/about_Ui.dart';
import 'package:rakibsk/screen/helpDesk/helpdesk_Ui.dart';
import 'package:rakibsk/screen/listScreen/list_ui.dart';
import 'package:rakibsk/screen/liveChats/live_chat.dart';
import 'package:rakibsk/screen/locationScreens/CityAreaSelectionScreen.dart';
import '../../extra/colors.dart';
import '../School/school_ui.dart';
import '../hosptal_Screen/hosptal_ui.dart';
import '../invoiceScreens/invoice_screen.dart';
import '../searchfilters/search_filter_screen.dart';
import 'dasbord_cubit.dart';
import 'dashboard_state.dart';
import 'dashboard_items.dart';

class DashboardUi extends StatefulWidget {
  const DashboardUi({super.key});

  @override
  State<DashboardUi> createState() => _DashboardUiState();
}

class _DashboardUiState extends State<DashboardUi> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 6,
          centerTitle: true,
          title: Text(
            "DASHBOARD",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: MyColor.deepPurple,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                return Text(
                  state.message,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 3.5,
                ),
                itemCount: dashboardItems.length,
                itemBuilder: (context, index) {
                  final item = dashboardItems[index];
                  return GestureDetector(
                    onTap: () => _handleNavigation(context, item['title']!),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.asset(
                                item['image']!,
                                height: 36,
                                width: 36,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(item['icon'] as IconData?, size: 30, color: Colors.black87),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['title']!,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: MyColor.deepPurple,
                ),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage('assets/images/sk.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Welcome Nic',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'rakibshaikh328@gmail.com',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              buildDrawerItem(Icons.home, "Home"),
              buildDrawerItem(Icons.settings, "Settings"),
              buildDrawerItem(FontAwesomeIcons.whatsapp, "Whatsapp Group"),
              buildDrawerItem(Icons.logout, "Logout"),

            ],
          ),
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, String title) {
    final routeMap = {
      'School': const SchoolInformationScreen(),
      'Hospital': const UserListScreen(),
      'About': const AboutUi(),
      'Help Dept': const HelpdeskUi(),
      'Live Chat': MessagingScreen(),
      'Invoice Bill': InvoiceScreen(),
      'city area': CityAreaSelectionScreen(),
      'Search Filter': SearchFilterScreen(),
    };

    if (routeMap.containsKey(title)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => routeMap[title]!),
      );
    } else {
      context.read<DashboardCubit>().updateMessage('$title tapped!');
    }
  }

  ListTile buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      onTap: () {
        context.read<DashboardCubit>().updateMessage('$title selected!');
        Navigator.pop(context);
      },
    );
  }
}
