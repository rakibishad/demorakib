import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_cubit.dart';
import 'login_state.dart';
import '../../extra/colors.dart';
import '../../widgets/text_input_field_password.dart' as pwd;
import '../../widgets/text_input_fields.dart' as email;
import '../dashBoard_screen/dashboard_ui.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(text: "rakibraihan1996@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "123456");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login Screen", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: MyColor.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const DashboardUi()),
                );
              } else if (state is LoginError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("❌ ${state.message}")),
                );
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/login.jpg',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),

                    // Email
                    email.TextInputFields(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email, color: Colors.brown),
                      validator: (value) => context.read<LoginCubit>().emailChanged(value),
                      onChanged: (value) => context.read<LoginCubit>().emailChanged(value),
                    ),
                    const SizedBox(height: 10),

                    // Password
                    pwd.TextInputFieldPassword(
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock, color: Colors.brown),
                      validator: (value) => context.read<LoginCubit>().passwordChanged(value),
                      onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();
                          context.read<LoginCubit>().login(email, password);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Login"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
