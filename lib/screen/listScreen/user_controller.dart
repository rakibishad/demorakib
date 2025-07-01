import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 
import 'package:rakibsk/screen/listScreen/user_model.dart';



class UserController extends GetxController {
  var users = <User>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List userJson = data['data'];
        users.value = userJson.map((e) => User.fromJson(e)).toList();
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong: $e';
    } finally {
      isLoading(false);
    }
  }
}
