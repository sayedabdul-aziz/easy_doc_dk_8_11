part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSucessState extends AuthState {}

class LoginErrorState extends AuthState {}
