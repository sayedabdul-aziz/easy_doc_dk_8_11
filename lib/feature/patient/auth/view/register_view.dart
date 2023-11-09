import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_doc_dk_8_11/core/app_color.dart';
import 'package:easy_doc_dk_8_11/feature/patient/auth/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();

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
          child: _signUp(),
        ),
      ),
    );
  }

  Widget _signUp() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Register Now as a Patient',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            TextFormField(
              focusNode: f1,
              keyboardType: TextInputType.name,
              controller: _displayName,
              style: TextStyle(color: AppColors.textColor),
              decoration: const InputDecoration(
                hintText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
              onFieldSubmitted: (value) {
                f1.unfocus();
                FocusScope.of(context).requestFocus(f2);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter the Name';
                return null;
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            TextFormField(
              focusNode: f2,
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              style: TextStyle(color: AppColors.textColor),
              decoration: const InputDecoration(
                hintText: 'Sayed@example.com',
                prefixIcon: Icon(Icons.email_rounded),
              ),
              onFieldSubmitted: (value) {
                f2.unfocus();
                FocusScope.of(context).requestFocus(f3);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the Email';
                } else if (!emailValidate(value)) {
                  return 'Please enter correct Email';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            TextFormField(
              style: TextStyle(color: AppColors.textColor),
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
              focusNode: f3,
              controller: _passwordController,
              onFieldSubmitted: (value) {
                f3.unfocus();
                FocusScope.of(context).requestFocus(f4);
              },
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter the Password';
                return null;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // showLoaderDialog(context);
                      _registerAccount();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: AppColors.primaryColor,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text(
                    "Register",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: getsmallStyle(color: AppColors.textColor),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const SignIn(),
                          ));
                        },
                        child: Text(
                          'Sign in',
                          style: getsmallStyle(color: AppColors.primaryColor),
                        ))
                  ],
                ),
              ),
            ),
          ],
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
        FocusScope.of(context).requestFocus(f2);
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
