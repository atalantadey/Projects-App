import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:projects/features/auth/presentation/screens/login_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Welcome to Projects -  Your Smart Task Manager",
            body:
                "Effortlessly organize your tasks with AI-powered assistance and a clean, intuitive design.",
            image: Center(
              child: Image.asset(
                'assets/images/intro_1.jpg',
                height: 400.0,
              ),
            ),
          ),
          PageViewModel(
            title: "Organize Your Day in Seconds",
            body:
                "Easily add, edit, and delete tasks using our AI chatbot or simple voice commands.",
            image: Center(
              child:
                  Image.asset('assets/images/login_tasks.jpg', height: 300.0),
            ),
          ),
          PageViewModel(
            title: "Stay Focused, Stay Ahead",
            body:
                "Prioritize tasks, set deadlines, and boost your productivity with ease.",
            image: Center(
                child: Image.asset('assets/images/intro_3.jpg', height: 300.0)),
          ),
        ],
        onDone: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => LoginScreen()));
        },
        done: const Text(
          "Get Started",
          style: TextStyle(color: Colors.white),
        ),
        doneStyle: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.green),
        ),
        showNextButton: false,
        showSkipButton: false,
        dotsDecorator: DotsDecorator(
          size: const Size(10.0, 10.0),
          color: Colors.green,
          activeSize: const Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        autoScrollDuration: 4000,
        globalBackgroundColor: Colors.green[30],
      ),
    );
  }
}
