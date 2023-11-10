import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se7ety_dk_8_11/core/app_color.dart';
import 'package:se7ety_dk_8_11/feature/patient/auth/view/login_view.dart';

class PatientRegisterView extends StatefulWidget {
  const PatientRegisterView({super.key});

  @override
  _PatientRegisterViewState createState() => _PatientRegisterViewState();
}

class _PatientRegisterViewState extends State<PatientRegisterView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisable = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'سجل حساب جديد  "مريض"',
                    style: getTitleStyle(),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _displayName,
                    style: TextStyle(color: AppColors.black),
                    decoration: InputDecoration(
                      hintText: 'الاسم',
                      hintStyle: getbodyStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'من فضلك ادخل الاسم';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    textAlign: TextAlign.end,
                    decoration: const InputDecoration(
                      hintText: 'Sayed@example.com',
                      prefixIcon: Icon(Icons.email_rounded),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل الايميل';
                      } else if (!emailValidate(value)) {
                        return 'من فضلك ادخل الايميل صحيحا';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    textAlign: TextAlign.end,
                    style: TextStyle(color: AppColors.black),
                    obscureText: isVisable,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: '********',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisable = !isVisable;
                            });
                          },
                          icon: Icon((isVisable)
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_rounded)),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) return 'من فضلك ادخل كلمة السر';
                      return null;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // showLoaderDialog(context);
                            // _signInWithEmailAndPassword();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.color1,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          "تسجيل حساب",
                          style: getTitleStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'لدي حساب ؟',
                          style: getbodyStyle(color: AppColors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const PatientLoginView(),
                              ));
                            },
                            child: Text(
                              'سجل دخول',
                              style: getbodyStyle(color: AppColors.color1),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Navigator.pop(context);
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text(
        "Error!",
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Email already Exists",
        style: GoogleFonts.lato(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showLoaderDialog(BuildContext context) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool emailValidate(String email) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  void _registerAccount() async {
    User? user;
    UserCredential? credential;

    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } catch (error) {
      if (error.toString().compareTo(
              '[firebase_auth/email-already-in-use] The email address is already in use by another account.') ==
          0) {
        showAlertDialog(context);
        print(
            "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print(user);
      }
    }
    user = credential?.user!;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      await user.updateDisplayName(_displayName.text);

      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': _displayName.text,
        'image': null,
        'birthDate': null,
        'email': user.email,
        'phone': null,
        'city': null,
      }, SetOptions(merge: true));
    } else {}
  }
}
