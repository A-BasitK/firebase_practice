import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());
  getOtp(String pNumber) async {
    try {
      emit(OtpLoading());

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: pNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          emit(OtpFetch(otp: credential.smsCode.toString()));
          emit(OtpLoading());
          var uc = await FirebaseAuth.instance.signInWithCredential(credential);
          emit(OtpSuccess());
        },
        verificationFailed: (FirebaseException fbe) {
          emit(OtpException(err: fbe.message.toString()));
        },
        codeSent: (String verificationID, int? code) {
          emit(OtpSent());
        },
        codeAutoRetrievalTimeout: (String timeout) {
          emit(OtpExpire());
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
