part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginSuccessful extends LoginState {}
class LoginLoading extends LoginState {}
class LoginUnSuccessful extends LoginState {}
class LoginException extends LoginState {}
