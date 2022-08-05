import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/controllers/cubits/login_cubit.dart';
import 'package:firebase_practice/custom_widgets/custom_button.dart';
import 'package:firebase_practice/custom_widgets/custom_navigation_text.dart';
import 'package:firebase_practice/custom_widgets/custom_textfield.dart';
import 'package:firebase_practice/shared_preferences/user_prefs.dart';
import 'package:firebase_practice/views/homepage.dart';
import 'package:firebase_practice/views/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    "Welcome",
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
                  child:BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) async{
                      if (state is LoginLoading) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ));
                      } else if (state is LoginSuccessful) {
                        Navigator.pop(context);
                        await UserPreferences.setUserData(FirebaseAuth.instance.currentUser!.uid);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login Successful")));
                      } else if (state is LoginUnSuccessful) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login UnSuccessful")));
                      }
                      else{
                        print("Another Error");
                      }
                    },
                    child: CustomButton(txt: "Sign In"),
                  ),
                  onTap: () {
                   context.read<LoginCubit>().getLoginData(emailController.text, passwordController.text);
                  }
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: CustomNavigationText(
                  txt1: "Don't have an Account ",
                  txt2: "Sign up",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
