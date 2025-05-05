import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/login_screen/login_screen_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/main_screen/main_screen_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/registration_screen/registration_screen_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationScreenBloc, RegistrationScreenState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.read<MainScreenBloc>().add(AuthSuccessEvent());
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Purple wave background
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height:
                    MediaQuery.of(context).size.height *
                    0.35, // Changed from 0.4 to 0.5
                decoration: const BoxDecoration(color: Color(0xFF8560E9)),
                child: const Padding(
                  padding: EdgeInsets.only(
                    top: 200,
                    left: 48,
                  ), // Changed from 60 to 100
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Регистрация',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Registration form
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                    ), // Increased height to move form down
                    TextField(
                      controller: _loginController,
                      decoration: InputDecoration(
                        hintText: 'Введите логин',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<
                      RegistrationScreenBloc,
                      RegistrationScreenState
                    >(
                      builder: (context, state) {
                        final borderColor =
                            !state.isCorrect ? Colors.red : Colors.grey;
                        return Column(
                          children: [
                            TextField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                hintText: 'Введите пароль',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed:
                                      () => setState(
                                        () =>
                                            _isPasswordVisible =
                                                !_isPasswordVisible,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _confirmPasswordController,
                              obscureText: !_isConfirmPasswordVisible,
                              decoration: InputDecoration(
                                hintText: 'Повторите пароль',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: borderColor),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed:
                                      () => setState(
                                        () =>
                                            _isConfirmPasswordVisible =
                                                !_isConfirmPasswordVisible,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<
                      RegistrationScreenBloc,
                      RegistrationScreenState
                    >(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_loginController.text.isEmpty ||
                                  _passwordController.text.isEmpty ||
                                  _confirmPasswordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Пожалуйста, заполните все поля',
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (_passwordController.text !=
                                  _confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Пароли не совпадают'),
                                  ),
                                );
                                return;
                              }

                              BlocProvider.of<RegistrationScreenBloc>(
                                context,
                              ).add(
                                RegistrationScreenCheckEvent(
                                  login: _loginController.text,
                                  password: _passwordController.text,
                                ),
                              );

                              if (state.isSuccess) {
                                BlocProvider.of<RegistrationScreenBloc>(
                                  context,
                                ).add(RegistrationScreenSuccessEvent());
                              }
                              if (!state.isCorrect) {
                                BlocProvider.of<RegistrationScreenBloc>(
                                  context,
                                ).add(RegistrationScreenBadCreditalsEvent());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8C52FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Зарегистрироваться',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.8); // Changed from 0.8 to 0.9

    var firstControlPoint = Offset(
      size.width * 0.25,
      size.height,
    ); // Adjusted y-coordinate
    var firstEndPoint = Offset(size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(
      size.width * 0.75,
      size.height * 0.6,
    ); // Adjusted y-coordinate
    var secondEndPoint = Offset(size.width, size.height * 0.8);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
