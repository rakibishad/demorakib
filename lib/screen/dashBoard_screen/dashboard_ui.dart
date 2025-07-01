import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakibsk/screen/about_Screen/about_Ui.dart';
import 'package:rakibsk/screen/helpDesk/helpdesk_Ui.dart';
import 'package:rakibsk/screen/listScreen/list_ui.dart';
import '../School/school_ui.dart';
import '../hosptal_Screen/hosptal_ui.dart';
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
        appBar: AppBar(
          title: Text(
            "DASHBOARD",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 1,
            ),
          ),
          backgroundColor: Colors.deepPurple,
          elevation: 4,
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                return Text(
                  state.message,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple,
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
                    onTap: () {
                      if (item['title'] == 'School') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SchoolInformationScreen()),
                        );
                      } else if (item['title'] == 'Hospital') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserListScreen()),
                        );
                      } else if (item['title'] == 'About') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AboutUi()),
                        );
                      }else if (item['title'] == 'Help Dept') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpdeskUi()),
                        );
                      }
                      else {
                        context
                            .read<DashboardCubit>()
                            .updateMessage("${item['title']} tapped!");
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple.shade100,
                            Colors.deepPurple.shade50,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.shade200,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              item['image']!,
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
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
          backgroundColor: Colors.grey[100],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage('assets/images/splash.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Welcome, User',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Dashboard Navigation',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              buildDrawerItem(Icons.home, "Home", context),
              buildDrawerItem(Icons.settings, "Settings", context),
              buildDrawerItem(Icons.logout, "Logout", context),
              buildDrawerItem(Icons.backup, "Backup", context),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),
      onTap: () {
        context.read<DashboardCubit>().updateMessage("$title selected!");
      },
    );
  }
}
