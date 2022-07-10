import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytutor/views/loginscreen.dart';

import 'package:mytutor/constants.dart';


class SignUP extends StatefulWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  State<SignUP> createState() => _SignUptState();
}

class _SignUptState extends State<SignUP> {
  late double screenHeight, screenWidth, ctrwidth;

 
  final TextEditingController _nameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
   final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _addressEditingController =
      TextEditingController();
  


  @override
  void dispose() {
    debugPrint("dispose was called");
    _nameEditingController.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _phoneEditingController.dispose();
    _addressEditingController.dispose();
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {
      ctrwidth = screenWidth / 1.5;
    }
    if (screenWidth < 800) {
      ctrwidth = screenWidth / 1.1;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new account'),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: SizedBox(
        width: ctrwidth,
        child: Form(
          
          child: Column(children: [
          
            const SizedBox(height: 15),
            TextFormField(
              
              controller: _nameEditingController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Valid Your  Name';
                }
                return null;
              },
            ),
             const SizedBox(height: 5),
            TextFormField(
              controller: _emailEditingController,
              decoration: InputDecoration(
                labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter valid email';
                }
                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);

                if (!emailValid) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
             const SizedBox(height: 5),
            TextFormField(
              controller: _passwordEditingController,
              validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
              maxLines: 1,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                labelText: 'Password',
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
             const SizedBox(height: 5),
            TextFormField(
              controller: _passwordEditingController,
              validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
              maxLines: 1,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                labelText: 'Repeat Password',
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),const SizedBox(height: 5),
            TextFormField(
              controller: _phoneEditingController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phoneNo';
                }
                if (value.length < 11) {
                  return "PhoneNO must be at least 11 characters";
                }
                return null;
              },
              maxLines: 1,
          
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone_outlined,),
                  labelText: 'PhoneNo',
                hintText: 'Enter your PhoneNo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
              const SizedBox(height: 15),
             
            TextFormField(
              controller: _addressEditingController,
              minLines: 6,
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              decoration: InputDecoration(
                  labelText: 'Home address',
                  hintText: 'Enter your home address',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Valid Your Home Address';
                }
                return null;
              },
            ),
              

            
            const SizedBox(height: 10),
            SizedBox(
              width: screenWidth,
              height: 50,
              child: ElevatedButton(
                child: const Text("Create"),
                onPressed: () {
                  _insertDialog();
                },
              ),
            ),
            const SizedBox(height: 10),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Register yet an account? ",
                    style: TextStyle(fontSize: 16.0)),
                GestureDetector(
                  onTap: () => {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginScreen ()))
                  },
                  child: const Text(
                    " Sign in",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ))),
    );
  }
void _insertDialog() {
    
     showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Register",
              style: TextStyle(),
            ),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _insertAccount();
                },
              ),
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  
  
 

  void _insertAccount() {
    
    String _name = _nameEditingController.text;
    String _email = _emailEditingController.text;
    String _password = _passwordEditingController.text;
    String _phone = _phoneEditingController.text;
    String _homeaddress= _addressEditingController.text;
    
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor3/mobile/php/signup.php"),
        body: {
          "name": _name,
          "email": _email,
          "password": _password,
          "phone": _phone,
          "homeaddress": _homeaddress,
          
          
        }).then((response) {
      print(response.body);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const LoginScreen()));
      } else {
        Fluttertoast.showToast(
            msg: data['status'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    });
  }
}