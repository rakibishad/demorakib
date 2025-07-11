import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakibsk/extra/colors.dart';
import 'package:rakibsk/screen/about_Screen/setting_screen.dart';
import 'package:rakibsk/screen/about_Screen/webview_screen.dart';

import '../freecourse_screen/freecourseUi.dart';
import '../home_Screen/home.dart';




class AboutUi extends StatefulWidget {
  const AboutUi({super.key});

  @override
  State<AboutUi> createState() => _AboutUiState();
}

class _AboutUiState extends State<AboutUi> {
  @override




  bool showAllCourses = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: const Text("Hi, Rakib",
            style: TextStyle(color: Colors.white),) ,

        actions: const [
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [

            // Search Bar
            Container(
              color: Colors.deepPurple,
              padding: const EdgeInsets.all(16),
              child: TextField(
                onSubmitted: (value) {
                  Fluttertoast.showToast(
                    msg: "Please wait...",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Search here...',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),


              ),
            ),


            // Category Grid
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                //  CategoryItem(icon: Icons.category, label: "Category"),
                  CategoryItem(icon: Icons.class_, label: "Classes"),
                  CategoryItem(icon: Icons.school, label: "Free Course"),
                  CategoryItem(icon: Icons.book, label: "BookStore"),
                  CategoryItem(icon: Icons.live_tv, label: "Live Course"),
                  CategoryItem(icon: Icons.leaderboard, label: "LeaderBoard"),
                  CategoryItem(
                    icon: Icons.school,
                    label: "Free Course",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FreeCourseUi(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),


            // Courses

            const SizedBox(height: 10),

            // Course Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Courses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showAllCourses = !showAllCourses;
                      });
                    },
                    child: Text(
                      showAllCourses ? "Show less" : "See all",
                      style: const TextStyle(color: MyColor.deepPurple),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // First Row of Courses
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Expanded(child: CourseCard(title: "Flutter", videos: 35)),
                  SizedBox(width: 16),
                  Expanded(child: CourseCard(title: "React Native", videos: 55)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Additional Courses (Only if showAllCourses == true)
            if (showAllCourses) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Expanded(child: CourseCard(title: "Android", videos: 20)),
                    SizedBox(width: 16),
                    Expanded(child: CourseCard(title: "Java", videos: 25)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ],

        ),

      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // highlight the Courses tab
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          if (index == 1) {
            // Navigate to Wishlist WebView
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  WebViewPage()),
            );
          } else if (index == 2) {
            // Navigate to Profile screen if needed
          }
          // index 0 is current page, so do nothing
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlist"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
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
                    'About Navigation',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            buildDrawerItem(Icons.offline_bolt, "offline", context),
            buildDrawerItem(Icons.online_prediction, "Online Shoaping", context),
            buildDrawerItem(Icons.fullscreen_outlined, "Full Course", context),
            buildDrawerItem(Icons.logout, "Logout", context),
          ],
        ),
      ),
    );
  }
  ListTile buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: MyColor.deepPurple),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),
      onTap: () {
        print("Tapped: $title");
        Navigator.pop(context); // Close drawer first

        if (title == "offline") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
        else if (title == "Online Shoaping") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );


      } else if (title == "Logout") {
          Fluttertoast.showToast(msg: "Logged out!");
          // Navigate to login if needed
        } else if (title == "Backup") {
          // Navigate to backup screen if needed
        } else {
          Fluttertoast.showToast(msg: "$title selected!");
        }
      },

    );
  }

}



class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.deepPurple, size: 30),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}


class CourseCard extends StatelessWidget {
  final String title;
  final int videos;

  const CourseCard({super.key, required this.title, required this.videos});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Spacer(),
          Text("$videos Videos", style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
