import 'package:easy_doc_dk_8_11/core/app_color.dart';
import 'package:easy_doc_dk_8_11/feature/patient/auth/view/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();

  bool isVisable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: withEmailPassword());
  }

  Widget withEmailPassword() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SizedBox(
              //   width: double.infinity,
              //   child: Container(
              //     child: Image.asset(
              //       'assets/vector-doc2.jpg',
              //       scale: 3.5,
              //     ),
              //   ),
              // ),

              Text(
                'Sign in Now as a Patient .',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              TextFormField(
                focusNode: f1,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                style: TextStyle(color: AppColors.textColor),
                decoration: const InputDecoration(
                  hintText: 'Sayed@example.com',
                  prefixIcon: Icon(Icons.email_rounded),
                ),
                onFieldSubmitted: (value) {
                  f1.unfocus();
                  FocusScope.of(context).requestFocus(f2);
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
                focusNode: f2,
                controller: _passwordController,
                onFieldSubmitted: (value) {
                  f2.unfocus();
                  FocusScope.of(context).requestFocus(f3);
                },
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter the Password';
                  return null;
                },
              ),
              // Container(
              //   alignment: Alignment.centerRight,
              //   padding: EdgeInsets.only(top: 5),
              //   child: Text(
              //     'Forgot Password?',
              //     style: getsmallStyle(),
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.only(top: 25.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    focusNode: f3,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // showLoaderDialog(context);
                        // _signInWithEmailAndPassword();
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
                      "Sign In",
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
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Haven\'t an account?',
                        style: getsmallStyle(color: AppColors.textColor),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ));
                          },
                          child: Text(
                            'Create One !',
                            style: getsmallStyle(color: AppColors.primaryColor),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

  void _signInWithEmailAndPassword() async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (!user!.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } catch (e) {
      const snackBar = SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            Text(" There was a problem signing you in"),
          ],
        ),
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
