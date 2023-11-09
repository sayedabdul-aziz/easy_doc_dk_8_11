import 'package:easy_doc_dk_8_11/core/app_color.dart';
import 'package:easy_doc_dk_8_11/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBYO73XHSeiNuIucj4m_2_A2920NnNIwWI',
          appId: 'com.example.easy_doc_dk_8_11',
          messagingSenderId: '612853651599',
          projectId: 'easydoc-7552d'));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          snackBarTheme: SnackBarThemeData(backgroundColor: AppColors.redColor),
          appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0.0,
              actionsIconTheme: IconThemeData(color: AppColors.primaryColor),
              backgroundColor: AppColors.white),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide.none,
            ),
            filled: true,
            suffixIconColor: AppColors.primaryColor,
            prefixIconColor: AppColors.primaryColor,
            fillColor: AppColors.scaffoldBG,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          dividerTheme: DividerThemeData(
            color: AppColors.textColor,
            indent: 10,
            endIndent: 10,
          ),
          brightness: Brightness.light,
          fontFamily: GoogleFonts.poppins().fontFamily),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
