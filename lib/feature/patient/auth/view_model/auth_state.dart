part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSucessState extends AuthState {}

class LoginErrorState extends AuthState {
  final String error;

  LoginErrorState({required this.error});
}
// ---------------------

class RegisterLoadingState extends AuthState {}

class RegisterSucessState extends AuthState {}

class RegisterErrorState extends AuthState {
  final String error;

  RegisterErrorState({required this.error});
}
