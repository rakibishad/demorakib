import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakibsk/screen/listScreen/user_controller.dart';

import '../../extra/colors.dart';



class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(title: const Text('Gmail List'),titleTextStyle: const TextStyle(color: Colors.white,fontSize: 24),
        centerTitle: true,backgroundColor: MyColor.cyan,),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final user = controller.users[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(user.avatar),
                ),
                title: Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  user.email,
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ),
            );
          },
        );

      }),
    );
  }
}
