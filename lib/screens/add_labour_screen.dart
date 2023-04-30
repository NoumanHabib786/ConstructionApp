import 'package:flutter/material.dart';
import 'package:flutter_application_12/screens/main_screen.dart';
import 'package:flutter_application_12/services/db_helper_labour.dart';

import '../models/labour_model.dart';

class AddLabourScreen extends StatefulWidget {
  const AddLabourScreen({super.key});

  @override
  State<AddLabourScreen> createState() => _AddLabourScreenState();
}

class _AddLabourScreenState extends State<AddLabourScreen> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Add Labour"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text(
                  "What are you thinking about?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    label: Text("Labour"),
                    hintText: "Enter Labour",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    label: Text("Description"),
                    hintText: "Enter description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 400,
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      final name = nameController.text;
                      final description = descriptionController.text;
                      final LabourModel data =
                          LabourModel(name: name, field: description);
                      DbHelperLabour.addUser(data);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const MainScreen();
                        },
                      ));
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    )),
                    child: const Text("Save", style: TextStyle(fontSize: 20)),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
