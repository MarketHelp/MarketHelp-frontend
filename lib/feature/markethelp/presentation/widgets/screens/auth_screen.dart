import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/main_screen/main_screen_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and app name
              Image.asset('assets/auth/logo_icon.png', height: 154, width: 154),
              const SizedBox(height: 12),
              const Text(
                'Market Help',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),

              // Login button
              Center(
                child: SizedBox(
                  width: 320,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<MainScreenBloc>(
                        context,
                      ).add(LoginScreenEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8C52FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Вход',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Registration button
              Center(
                child: SizedBox(
                  width: 320,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      BlocProvider.of<MainScreenBloc>(
                        context,
                      ).add(RegistrationScreenEvent());
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF8C52FF)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Регистрация',
                      style: TextStyle(color: Color(0xFF8C52FF), fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
