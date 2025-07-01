import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repostiroy/user_repository.dart';
import 'cubit/registation_cubit.dart';
import 'cubit/state_cubit.dart';


class LoginScreen extends StatelessWidget {
  final usernameController = TextEditingController(text: "emilys");
  final passwordController = TextEditingController(text: "emilyspass");

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(UserRepository()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('✅ Logged in! Token: ${state.token}')),
                );
              } else if (state is LoginError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('❌ Error: ${state.message}')),
                );
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final username = usernameController.text.trim();
                      final password = passwordController.text.trim();
                      context.read<LoginCubit>().login(username, password);
                    },
                    child: const Text("Login"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}


