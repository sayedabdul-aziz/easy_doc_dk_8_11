import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se7ety_dk_8_11/core/app_color.dart';
import 'package:se7ety_dk_8_11/feature/auth/view_model/auth_cubit.dart';
import 'package:se7ety_dk_8_11/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBYO73XHSeiNuIucj4m_2_A2920NnNIwWI',
          appId: 'com.example.se7ety_dk_8_11',
          messagingSenderId: '612853651599',
          projectId: 'easydoc-7552d'));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.white,
            snackBarTheme:
                SnackBarThemeData(backgroundColor: AppColors.redColor),
            appBarTheme: AppBarTheme(
                titleTextStyle: getTitleStyle(color: AppColors.white),
                centerTitle: true,
                elevation: 0.0,
                actionsIconTheme: IconThemeData(color: AppColors.color1),
                backgroundColor: AppColors.color1),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.only(
                  left: 20, top: 10, bottom: 10, right: 20),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              suffixIconColor: AppColors.color1,
              prefixIconColor: AppColors.color1,
              fillColor: AppColors.scaffoldBG,
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            dividerTheme: DividerThemeData(
              color: AppColors.black,
              indent: 10,
              endIndent: 10,
            ),
            brightness: Brightness.light,
            fontFamily: GoogleFonts.cairo().fontFamily),
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
        builder: (BuildContext context, Widget? child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
      ),
    );
  }
}
