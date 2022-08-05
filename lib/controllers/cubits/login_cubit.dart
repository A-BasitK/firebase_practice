import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  getLoginData(String email,String password) async{
      emit(LoginLoading());
      try {
      var uc = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password);
      if(uc.user!=null){
        emit(LoginSuccessful());
      }
      else{ emit(LoginUnSuccessful());}
      } on FirebaseAuthException catch (e) {
        emit(LoginUnSuccessful());
      print(e);
      }
    }
  }

