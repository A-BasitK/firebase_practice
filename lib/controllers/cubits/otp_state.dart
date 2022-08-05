part of 'otp_cubit.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}
class OtpFetch extends OtpState {
  String otp;
  OtpFetch({required this.otp});
}
class OtpSuccess extends OtpState {}
class OtpExpire extends OtpState {}
class OtpLoading extends OtpState {}
class OtpException extends OtpState {
  String err;
  OtpException({required this.err});
}
class OtpSent extends OtpState {}

