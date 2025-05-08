import 'package:either_dart/either.dart';

abstract class AuthState {}

class AuthinitState extends AuthState{}

class AuthloadingState extends AuthState{}

class AuthRequestSuccessState extends AuthState{
  Either<String, String> response;
  AuthRequestSuccessState(this.response);
}