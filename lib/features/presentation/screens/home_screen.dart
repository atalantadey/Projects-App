import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projects/features/auth/domain/auth.dart';
import 'package:projects/features/auth/presentation/screens/login_screen.dart';
import 'package:projects/features/presentation/widgets/custom_snack.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final User? user = Auth().currentUser;
  

  Future<void> _signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return Text('Home Screen');
  }

  Widget _userId() {
    return Text(user?.email ?? 'User Email');
  }

  Widget _signOutButton(context) {
    return ElevatedButton(
      onPressed: () {
        _signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
        ;
        CustomSnackbar.show(
          context: context,
          message: 'Successfully Signed Out',
          isError: false,
        );
      },
      child: Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _title(),
            _userId(),
            _signOutButton(context),
          ],
        ),
      ),
    );
  }
}
