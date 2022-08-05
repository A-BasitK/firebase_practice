import 'package:firebase_practice/controllers/cubits/Invoice_cubits/invoice_controller_cubit.dart';
import 'package:firebase_practice/controllers/cubits/Invoice_cubits/invoice_delete_controller_cubit.dart';
import 'package:firebase_practice/controllers/cubits/login_cubit.dart';
import 'package:firebase_practice/controllers/cubits/otp_cubit.dart';
import 'package:firebase_practice/controllers/cubits/signup_cubit.dart';
import 'package:firebase_practice/shared_preferences/user_prefs.dart';
import 'package:firebase_practice/views/homepage.dart';
import 'package:firebase_practice/views/login_screen.dart';
import 'package:firebase_practice/views/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controllers/cubits/Invoice_cubits/invoice_read_controller_cubit.dart';
import 'controllers/cubits/Invoice_cubits/invoice_update_controller_cubit.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
            create: (BuildContext context) => LoginCubit()),
        BlocProvider<SignupCubit>(
            create: (BuildContext context) => SignupCubit()),
        BlocProvider<OtpCubit>(create: (BuildContext context) => OtpCubit()),
        BlocProvider(create: (context) => InvoiceControllerCubit()),
        BlocProvider(create: (context) => InvoiceReadControllerCubit()),
        BlocProvider(create: (context) => InvoiceUpdateControllerCubit()),
        BlocProvider(create: (context) => InvoiceDeleteControllerCubit()),
      ],
      child: MaterialApp(
          home: UserPreferences.getUserData() != null
              ? HomePage()
              : LoginScreen()),
    );
  }
}
