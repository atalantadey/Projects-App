import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:projects/features/presentation/screens/home_screen.dart';

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
                child: Image.asset('assets/images/projects_logo.png',
                    height: 300.0)),
          ),
          PageViewModel(
            title: "Organize Your Day in Seconds",
            body:
                "Easily add, edit, and delete tasks using our AI chatbot or simple voice commands.",
            image: Center(
                child: Image.asset('assets/images/projects_logo.png',
                    height: 175.0)),
          ),
          PageViewModel(
            title: "Stay Focused, Stay Ahead",
            body:
                "Prioritize tasks, set deadlines, and boost your productivity with ease.",
            image: Center(
                child: Image.asset('assets/images/projects_logo.png',
                    height: 175.0)),
          ),
        ],
        onDone: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomeScreen()));
        },
        done: const Text(
          "Get Started",
          style: TextStyle(color: Colors.white),
        ),
        doneStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
        showNextButton: false,
        autoScrollDuration: 4000,
        globalBackgroundColor: Colors.green[50],
      ),
    );
  }
}
