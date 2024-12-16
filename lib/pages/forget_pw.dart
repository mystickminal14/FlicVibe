import 'package:flick/custom_widgets/custom_btn.dart';
import 'package:flick/custom_widgets/head.dart';
import 'package:flutter/material.dart';
import '../database/auth.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email='';
  bool isLoading=false;
  Color hexToColor(String hex) {
    hex = hex.replaceAll("#", ""); // Remove the # symbol if present
    return Color(int.parse("FF$hex", radix: 16)); // Convert to Color
  }
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return isLoading? Center(child: const CircularProgressIndicator()): Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const AppHeader(title: 'Forget Password'),
              const Text(
                'Forgot Password',
                style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'poppins'),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Enter the email associated with your account and we’ll send an email instructions to reset your password',
                style: TextStyle(
                  fontFamily: 'poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const Text(
                'Email',
                style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value){
                  setState(() {
                    email=value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Email Address",
                  labelStyle:
                  TextStyle(color: Colors.green), // Placeholder text
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                  ), // Adds a border around the TextField
                ),
              )
            ]),
            Column(
              children: [
                // Search Email Button
                CustomButton(text: 'Search Email', onPressed: ()async{
                  setState(() {
                    isLoading=true;
                  });
                  final result= await _auth.passwordReset(context,email);
                  setState(() {
                    isLoading=false;
                  });
                }),
                const SizedBox(height: 10), // Add spacing between the buttons

                // Back Button
                CustomButton(text: 'Back', onPressed: (){Navigator.pushReplacementNamed(context, 'login');})
              ],
            )
          ],
        ),
      ),
    );
  }
}
