import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quicktask/app/modules/home/views/home_view.dart';
import 'package:quicktask/app/widgets/toast.dart';
import 'package:quicktask/components/rounded_button.dart';
import 'package:quicktask/constants.dart';
import 'package:quicktask/screens/add_modify_user_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String enteredUserName = '';
  String enteredPassword = '';
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  enteredUserName = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Username',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  enteredPassword = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password.',
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Color.fromARGB(255, 75, 7, 54),
                onPressed: () {
                  if (enteredPassword == 'admin' &&
                      enteredUserName == 'admin') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeView()));
                    showToast(
                      text: "Welcome to QuickTask",
                      state: ToastStates.success,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 2000),
                        content: Text(
                          'Invalid Details!',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        backgroundColor: Color(0xffCDBE78),
                      ),
                    );
                  }
                },
                title: 'Log In',
              ),
              const SizedBox(
                height: 12.0,
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to the signup screen or perform any other action
                  Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddModifyUserScreen()));
                    showToast(
                      text: "Sign up here!",
                      state: ToastStates.success,
                    );
                },
                child: const Text(
                  'Don\'t have an account? Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 75, 7, 54), // Change the color of the text
                    decoration: TextDecoration.underline, // Add underline
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
