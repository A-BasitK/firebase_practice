import 'package:firebase_practice/controllers/cubits/otp_cubit.dart';
import 'package:firebase_practice/custom_widgets/custom_button.dart';
import 'package:firebase_practice/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final verificationController = TextEditingController();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Verification"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: verificationController,
                  decoration: const InputDecoration(
                      hintText: "Enter your Phone Number with +92",
                      border: OutlineInputBorder())),
            )),
            const SizedBox(
              height: 29,
            ),
            Expanded(
                child: Align(
              alignment: Alignment.topCenter,
              child: BlocListener<OtpCubit, OtpState>(
                listener: (context, state) {
                  if (state is OtpLoading) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              content: SizedBox(
                                height: 80,
                                child: Center(child: CircularProgressIndicator()),
                              ),
                            ));
                  }
                  if (state is OtpSuccess) {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                  if (state is OtpException) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                      content: Text(state.err),
                      backgroundColor: Colors.red,
                    ));
                  }
                  if (state is OtpFetch) {
                    otpController.text = state.otp;
                  }
                  if (state is OtpSent) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Otp Sent"),
                      backgroundColor: Colors.green,
                    ));
                  }
                },
                child: InkWell(
                  child: CustomButton(txt: "Sent OTP"),
                  onTap: () {
                    String pnumber = verificationController.text.trim();
                    context.read<OtpCubit>().getOtp(pnumber);
                  },
                ),
              ),
            )),
            Expanded(
                child: PinCodeTextField(
              controller: otpController,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              onChanged: (String value) {},
              appContext: context,
              onCompleted: (String value) {},
            ))
          ],
        ),
      ),
    );
  }
}
