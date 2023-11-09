import 'package:easy_doc_dk_8_11/core/app_color.dart';
import 'package:easy_doc_dk_8_11/feature/patient/auth/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    // _getUser();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignIn()
                // user == null ? OnBoardingView() : MainPage(),
                ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('assets/logo.png', width: 300),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Healthy Tomorrow, Booked Today!',
              style: getsmallStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
