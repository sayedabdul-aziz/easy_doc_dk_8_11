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
}
