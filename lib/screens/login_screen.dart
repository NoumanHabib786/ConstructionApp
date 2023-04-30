import 'package:flutter/material.dart';
import 'package:flutter_application_12/models/user_model.dart';

import '../services/db_helper_user.dart';

class LoginScreen extends StatefulWidget {
  final UserModel? userModel;
  const LoginScreen({super.key, this.userModel});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController existController = TextEditingController();
    return Scaffold(
      body: Stack(children: [
        const Padding(
          padding: EdgeInsets.only(top: 130, left: 30),
          child: Text('Welcome to Construction  Built Environment',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 300, right: 30, left: 30),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    fillColor: Colors.black26,
                    filled: true,
                    hintText: 'Username',
                    icon: const Icon(Icons.supervised_user_circle_outlined,
                        size: 30, color: Colors.black),
                    hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.password_rounded,
                        size: 30, color: Colors.black),
                    fillColor: Colors.black26,
                    filled: true,
                    hintText: 'Password',
                    hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 150, right: 5),
                  child: TextButton(
                    onPressed: () {
                      setState(() {});
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(159, 30, 30, 100),
                    ),
                    child: TextField(controller: existController),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: TextButton(
                          onPressed: () async {
                            final UserModel user = UserModel(
                                name: nameController.text,
                                password: passwordController.text);
                            final db = await DbHelperUser.getDb();
                            var res = await db.rawQuery(
                                "SELECT * FROM users WHERE name = '${user.name}' AND password = '${user.password}'");
                            if (formKey.currentState!.validate()) {
                              if (res.length > 0) {
                                Navigator.pushNamed(context, 'mainScreen');
                              } else {
                                existController.text = "          invalid!";
                                nameController.clear();
                                passwordController.clear();
                              }
                            }
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              // const Color.fromRGBO(159, 30, 30, 100),
                              side: const BorderSide(width: 2.0),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                          child: const Text('Sign In'),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 20),
                  child: Row(children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Don’t have a account ?',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context,'signupScreen');
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    )
                  ]),
                )
              ]),
            ),
          ),
        )
      ]),
    );
  }
}
