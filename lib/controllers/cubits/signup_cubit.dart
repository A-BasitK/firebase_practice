import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  getSignUpData(String email,String password) async{
    emit(SignupLoading());
    try{
      var nu = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password);
      if(nu.user!=null){
        emit(SignupSuccessful());
      }
      else{
        emit(SignupUnsuccessful());
      }

    } on FirebaseException catch(e){
      print(e);
      emit(SignupUnsuccessful());
    }

  }
}
