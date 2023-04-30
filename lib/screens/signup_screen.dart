import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/db_helper_user.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController existController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Create Account',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, right: 30, left: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    fillColor: Colors.black26,
                    filled: true,
                    hintText: 'Name',
                    icon: const Icon(Icons.supervised_user_circle,
                        size: 30, color: Colors.black),
                    hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter phone no";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: Colors.black26,
                  filled: true,
                  hintText: 'Phone No ',
                  icon: const Icon(Icons.phone, size: 30, color: Colors.black),
                  hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter email";
                  }
                  return null;
                },
                // controller: _name,
                decoration: InputDecoration(
                  fillColor: Colors.black26,
                  filled: true,
                  hintText: 'Email',
                  icon: const Icon(Icons.email, size: 30, color: Colors.black),
                  hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  }
                  return null;
                },
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 25, top: 10),
                child: Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                    ),
                    Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(2, 3),
                              blurRadius: 3)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 270,
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          final UserModel user = UserModel(
                              name: nameController.text,
                              password: passwordController.text);
                          final db = await DbHelperUser.getDb();
                          var res = await db.rawQuery(
                              "SELECT * FROM users WHERE name = '${user.name}'");
                          if (formKey.currentState!.validate()) {
                            if (res.length == 0) {
                              DbHelperUser.addUser(user);
                              Navigator.pushNamed(context, 'mainScreen');
                            } else {
                              nameController.text = "User exists";
                              passwordController.clear();
                              phoneController.clear();
                              emailController.clear();
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
                        child: const Text('Sign Up'),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 35),
                child: Row(
                  children: const [
                    Text(
                      "--------------  ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    Text(
                      "or sign up with  ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    Text(
                      "--------------  ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.facebook, color: Colors.white),
                    label: const Text(
                      'Facebook',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 45),
                  child: SizedBox(
                    width: 110,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/gicon.png',
                        width: 24,
                      ),
                      label: const Text(
                        'Google',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                )
              ])
            ]),
          ),
        ),
      ),
    );
  }
}
