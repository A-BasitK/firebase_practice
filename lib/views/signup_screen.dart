import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/controllers/cubits/signup_cubit.dart';
import 'package:firebase_practice/shared_preferences/user_prefs.dart';
import 'package:firebase_practice/views/login_screen.dart';
import 'package:firebase_practice/views/verification_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_navigation_text.dart';
import '../custom_widgets/custom_textfield.dart';
import 'homepage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 700,
          child: ListView(
            children: [
              const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Registration",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 40,
              ),
              CustomTextField(
                hint_text: "Enter Email",
                controller: emailController,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 7,
              ),
              CustomTextField(
                  hint_text: "Enter Password",
                  controller: passwordController,
                  textInputAction: TextInputAction.done),
              const SizedBox(
                height: 70,
              ),
              InkWell(
                child: BlocListener<SignupCubit, SignupState> (
                  listener: (context, state) async {
                    if(state is SignupLoading){
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ));
                    }
                    else if(state is SignupSuccessful){
                      Navigator.pop(context);
                      await UserPreferences.setUserData(FirebaseAuth.instance.currentUser!.uid);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Signup Successful")));
                    }
                    else if(state is SignupUnsuccessful){
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Signup Unsuccessful")));
                    }
                  },
                  child: CustomButton(txt: "Sign Up"),
                ),
                onTap: () {
                  context.read<SignupCubit>().getSignUpData(emailController.text, passwordController.text);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: CustomNavigationText(
                  txt1: "Already have an Account ",
                  txt2: "Sign In",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 20,width: 50,
              child: Center(child: Text("Or Sign Up With Other Methods",style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold),)),),
              SizedBox(height: 15,),
              Row(children: [
                Expanded(child: CustomButton(txt: "Google")),
                SizedBox(width: 10,),
                Expanded(child: InkWell(child: CustomButton(txt: "Phone Number"),
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const VerificationScreen()));},
                )
                ),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
