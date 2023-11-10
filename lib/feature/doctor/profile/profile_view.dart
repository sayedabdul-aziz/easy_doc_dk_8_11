import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_dk_8_11/feature/welcome_view.dart';

class DoctorProfileView extends StatelessWidget {
  const DoctorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const WelcomeView(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout_outlined))
            ],
          ),
        ),
      ),
    );
  }
}
