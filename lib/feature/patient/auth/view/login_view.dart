import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_dk_8_11/core/app_color.dart';
import 'package:se7ety_dk_8_11/feature/patient/auth/view/register_view.dart';

class PatientLoginView extends StatefulWidget {
  const PatientLoginView({super.key});

  @override
  _PatientLoginViewState createState() => _PatientLoginViewState();
}

class _PatientLoginViewState extends State<PatientLoginView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  'سجل دخول الان "مريض"',
                  style: getTitleStyle(),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  textAlign: TextAlign.end,
                  decoration: const InputDecoration(
                    hintText: 'Sayed@example.com',
                    prefixIcon: Icon(Icons.email_rounded),
                  ),
                  textInputAction: TextInputAction.next,
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
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 5, right: 10),
                  child: Text(
                    'نسيت كلمة السر ؟',
                    style: getsmallStyle(),
                  ),
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
                        "تسجيل الدخول",
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
                        'ليس لدي حساب ؟',
                        style: getbodyStyle(color: AppColors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const PatientRegisterView(),
                            ));
                          },
                          child: Text(
                            'سجل الان',
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
    ));
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
