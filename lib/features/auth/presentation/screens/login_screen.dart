import 'package:dio_jwt_demo/core/util/api_constants.dart';
import 'package:dio_jwt_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dio_jwt_demo/features/auth/presentation/bloc/auth_event.dart';
import 'package:dio_jwt_demo/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController(
    text: ApiConstants.testLoginEmail,
  );
  final passwordController = TextEditingController(
    text: ApiConstants.testLoginPassword,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                context.go('/home');

              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Login failed: ${state.message}")),
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          LoginRequested(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
                      child: const Text('Login'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
