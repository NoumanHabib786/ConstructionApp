import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/db_helper_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // var res = widget.name;
    final formKey = GlobalKey<FormState>();
    TextEditingController existController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.blueGrey,
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
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Name',
                    // enabled: false,
                    icon: const Icon(Icons.supervised_user_circle,
                        size: 30, color: Colors.white),
                    hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
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
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Phone No ',
                  icon: const Icon(Icons.phone, size: 30, color: Colors.white),
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
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Email',
                  icon: const Icon(Icons.email, size: 30, color: Colors.white),
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
                      size: 30, color: Colors.white),
                  fillColor: Colors.white,
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
                            if (res.length > 0) {
                              DbHelperUser.updateUser(user);
                            } else {
                              nameController.text = "User not exists";
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
                        child: const Text('Update'),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
