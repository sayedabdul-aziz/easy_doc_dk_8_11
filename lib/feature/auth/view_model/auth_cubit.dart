import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  login(String email, String password) async {
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSucessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        emit(LoginErrorState(error: 'لا يوجد حساب علي هذا الايميل'));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        emit(LoginErrorState(error: 'كلمة السر التي ادخلتها غير صحيحة'));
      } else {
        emit(LoginErrorState(error: e.toString()));
      }
    }
  }

  registerPatient(String name, String email, String password) async {
    emit(RegisterLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user!;

      await user.updateDisplayName(name);

      FirebaseFirestore.instance.collection('patients').doc(user.uid).set({
        'name': name,
        'image': null,
        'birthDate': null,
        'email': user.email,
        'phone': null,
        'bio': null,
        'city': null,
      }, SetOptions(merge: true));
      emit(RegisterSucessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState(error: 'يوجد حساب بالفعل علي هذا الايميل'));
      } else if (e.code == 'weak-password') {
        emit(RegisterErrorState(error: 'كلمة السر التي ادخلتها ضعيفة جدا'));
      } else {
        emit(RegisterErrorState(error: e.toString()));
      }
    }
  }

  registerDoctor(String name, String email, String password) async {
    emit(RegisterLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user!;

      await user.updateDisplayName(name);

      FirebaseFirestore.instance.collection('doctors').doc(user.uid).set({
        'name': name,
        'image': null,
        'specialization': null,
        'rating': null,
        'email': user.email,
        'phone1': null,
        'phone2': null,
        'bio': null,
        'openHour': null,
        'closeHour': null,
        'address': null,
      }, SetOptions(merge: true));
      emit(RegisterSucessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState(error: 'يوجد حساب بالفعل علي هذا الايميل'));
      } else if (e.code == 'weak-password') {
        emit(RegisterErrorState(error: 'كلمة السر التي ادخلتها ضعيفة جدا'));
      } else {
        emit(RegisterErrorState(error: e.toString()));
      }
    }
  }

  updateDoctorData(
      {required String uid,
      required String specialization,
      required String image,
      required String email,
      required String phone1,
      String? phone2,
      required String bio,
      required String startTime,
      required String endTime,
      required String address}) async {
    emit(UpdateLoadingState());
    try {
      FirebaseFirestore.instance.collection('doctors').doc(uid).set({
        'image': image,
        'specialization': specialization,
        'rating': null,
        'email': email,
        'phone1': phone1,
        'phone2': phone2,
        'bio': bio,
        'openHour': startTime,
        'closeHour': endTime,
        'address': address,
      }, SetOptions(merge: true));
      emit(UpdateSucessState());
    } catch (e) {
      emit(UpdateErrorState(error: e.toString()));
    }

    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => const HomeView(),
    // ));
  }
}
