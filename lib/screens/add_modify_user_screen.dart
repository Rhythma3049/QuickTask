import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quicktask/app/constants/api_constants.dart';
import 'package:quicktask/app/exports.dart';
import 'package:quicktask/app/models/event_object.dart';
import 'package:quicktask/app/services/http_post.dart';
import 'package:quicktask/app/widgets/toast.dart';
import 'package:quicktask/constants.dart';
import 'package:quicktask/components/rounded_button.dart';
import 'package:http/http.dart' as http;
import 'package:quicktask/components/key.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:quicktask/screens/login_screen.dart';


class AddModifyUserScreen extends StatelessWidget {
  late String username;
  late String password;
  late String confirmPassword;
  late int id;
  late bool willAdd;

  AddModifyUserScreen(
      {this.username = '',
      this.password = '',
      this.confirmPassword = '',
      this.id = 0}) {
    willAdd = username.isEmpty;
  }


Future<bool?> saveUser(String username, String password) async {
    bool? success;
   final EventObject? eventObject = await httpPost(
      client: http.Client(),
      //appending the primary key is where the difference of updating vs new task comes in
      url:
           ApiConstants.user ,
      data: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,

      },
      
      ),
    );

        try {
          // Give the user the appropriate feedback
          switch (eventObject!.id) {
            case EventConstants.requestSuccessful:
              success = true;
              showToast(
                text: "User saved successfully",
                state: ToastStates.success,
              );
              Get.offAll(() =>               
              LoginScreen());
              break;

            case EventConstants.requestInvalid:
              success = false;
              showToast(
                text: "Invalid request",
                state: ToastStates.error,
              );
              break;

            case EventConstants.requestUnsuccessful:
              success = false;
              break;

            default:
              showToast(
                text: "Saving new user was not successful",
                state: ToastStates.error,
              );
              success = null;
              break;
          }
        } catch (exception) {
          success = null;
        }
      
    
    return success;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: const BoxDecoration(
            color: Color(0xffF2F2F2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  willAdd ? 'Add User' : 'Modify User',
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff383838),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: TextEditingController(),
                onChanged: (value) {
                  username = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter username.'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: true,
                controller: TextEditingController(),
                onChanged: (value) {
                  password = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter password.'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: true,
                controller: TextEditingController(),
                onChanged: (value) {
                  confirmPassword = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Confirm password.'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                color: Color.fromARGB(255, 75, 7, 54),
                onPressed: () async {
                  if (willAdd) {
                    if (username != '' &&
                        password != '' && (password == confirmPassword)) {
                      bool? statusCode =
                          await saveUser(username, password);
                    } else {
                      if(password != confirmPassword){
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 2000),
                          content: Text(
                            'Passwords do not match',
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
                      else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 2000),
                          content: Text(
                            'Fill all the details!',
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
                    }
                  }              },
                title: (willAdd) ? 'Add' : 'Modify',
              ),
              const SizedBox(
                height: 12.0,
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to the signup screen or perform any other action
                  Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                    showToast(
                      text: "Login here!",
                      state: ToastStates.success,
                    );
                },
                child: const Text(
                  'Already have an account? Login',
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
