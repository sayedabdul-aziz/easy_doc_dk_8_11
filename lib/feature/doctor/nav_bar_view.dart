import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety_dk_8_11/core/app_color.dart';
import 'package:se7ety_dk_8_11/feature/patient/appointments/appointments_view.dart';
import 'package:se7ety_dk_8_11/feature/patient/home/home_view.dart';
import 'package:se7ety_dk_8_11/feature/patient/profile/profile_view.dart';
import 'package:se7ety_dk_8_11/feature/patient/search/search_view.dart';

class DoctortNavBar extends StatefulWidget {
  const DoctortNavBar({super.key});

  @override
  _DoctortNavBarState createState() => _DoctortNavBarState();
}

class _DoctortNavBarState extends State<DoctortNavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeView(),
    const DoctorSearchView(),
    const AppointmentsView(),
    const PatientProfileView(),
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  String shortcut = "no action set";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: GNav(
                curve: Curves.easeOutExpo,
                rippleColor: Colors.grey,
                hoverColor: Colors.grey,
                haptic: true,
                tabBorderRadius: 20,
                gap: 5,
                activeColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: AppColors.color1,
                textStyle: GoogleFonts.lato(
                  color: Colors.white,
                ),
                tabs: const [
                  GButton(
                    iconSize: 28,
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    iconSize: 28,
                    icon: Icons.calendar_month_rounded,
                    text: 'Schedule',
                  ),
                  GButton(
                    iconSize: 29,
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
