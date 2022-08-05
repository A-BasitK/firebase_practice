part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}
class SignupSuccessful extends SignupState {}
class SignupUnsuccessful extends SignupState {}
class SignupLoading extends SignupState {}
class SignupException extends SignupState {}
