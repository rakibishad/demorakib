import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left-side vertical list
          Flexible(
            child: SizedBox(
              width: 150,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (ctx, i) {
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        const Icon(Icons.person),
                        const SizedBox(width: 8),
                        Text("Cat $i"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Right-side grid view
          Flexible(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      itemCount: 50,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 3 / 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(
                                  'https://commons.wikimedia.org/wiki/File:Sunflower_from_Silesia2.jpg',
                              ),

                            ),
                            const Positioned.fill(
                              child: Icon(Icons.play_circle_fill, color: Colors.white70, size: 48),
                            ),
                            const SizedBox(height: 6),
                            Text("Title $index"),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
