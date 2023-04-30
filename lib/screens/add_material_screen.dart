import 'package:flutter/material.dart';
import 'package:flutter_application_12/services/db_helper_material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/material_model.dart';
import 'main_screen.dart';

class AddMaterialScreen extends StatefulWidget {
  const AddMaterialScreen({super.key});

  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}

class _AddMaterialScreenState extends State<AddMaterialScreen> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Add Material"), centerTitle: true),
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
                    label: Text("Category"),
                    hintText: "Enter category",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    label: Text("Price"),
                    hintText: "Enter price",
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
                      final price = priceController.text;
                      final MaterialModel data =
                          MaterialModel(name: name, price: price);
                      DbHelperMaterial.addUser(data);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ImagePicker().pickImage(source: ImageSource.gallery);
        },
        child: Icon(Icons.photo_camera_sharp),
      ),
    );
  }

  // void getImage(ImageSource gallery)async {
  //   PickedFile imageFile = await picker.getImage(source: gallery);

  // }
}
