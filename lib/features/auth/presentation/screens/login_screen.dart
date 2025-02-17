import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projects/features/auth/domain/auth.dart';

import 'package:projects/features/presentation/screens/home_screen.dart';
import 'package:projects/features/presentation/widgets/custom_button.dart';
import 'package:projects/features/presentation/widgets/custom_snack.dart';
import 'package:projects/features/presentation/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  String? errormessage = '';
  bool isLogin = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _topAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
    ]).animate(_animationController);

    _bottomAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
    ]).animate(_animationController);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
      CustomSnackbar.show(
        context: context,
        message: 'Succesfully Logged In',
        isError: false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        // Show error message
        errormessage = e.message;
      });
      CustomSnackbar.show(
        context: context,
        message: errormessage!,
        isError: true,
      );
      //print(e);
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().signUpWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
      CustomSnackbar.show(
        context: context,
        message: 'Succesfully Signed In',
        isError: false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        // Show error message
        errormessage = e.message;
      });
      CustomSnackbar.show(
        context: context,
        message: errormessage!,
        isError: true,
      );
      //print(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await Auth().signInWithGoogle();
      CustomSnackbar.show(
          context: context,
          message: 'Succesfully Logged In using Google',
          isError: false);
    } catch (e) {
      setState(() {
        // Show error message
        CustomSnackbar.show(
          context: context,
          message: e.toString(),
          isError: true,
        );
      });
      //print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: _topAlignmentAnimation.value,
                end: _bottomAlignmentAnimation.value,
                colors: const [
                  Color(0xFF4CAF50), // Green
                  Color.fromARGB(255, 168, 226, 171), // Light Green
                  Color(0xFF2E7D32), // Dark Green
                ],
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo or Icon
                    Image.asset('assets/images/projects_logo.png', height: 100),
                    const SizedBox(height: 40),
                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                    ),
                    const SizedBox(height: 12),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          isLogin ? 'Forgot Password?' : '',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    // Login Button
                    CustomButton(
                      text: isLogin ? 'Login' : 'Sign Up',
                      onPressed: () {
                        // Add login logic here
                        isLogin
                            ? signInWithEmailAndPassword()
                            : createUserWithEmailAndPassword();
                      },
                    ),
                    const SizedBox(height: 32),

                    Column(
                      children: [
                        const Text(
                          'Or connect with',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => signInWithGoogle(),
                              child: Image.asset('assets/images/facebook.png',
                                  height: 40),
                            ),
                            const SizedBox(width: 36),
                            Image.asset('assets/images/google.png', height: 40),
                            const SizedBox(width: 36),
                            Image.asset('assets/images/twitter.png',
                                height: 40),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Signup Option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isLogin
                              ? "Don't have an account?"
                              : "Already have an account?",
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(
                            isLogin ? 'Sign Up' : 'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
