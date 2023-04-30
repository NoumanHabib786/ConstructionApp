import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_12/screens/add_labour_screen.dart';

import '../screens/card_screen.dart';
import '../models/material_model.dart';
import '../services/db_helper_material.dart';
import 'add_material_screen.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MaterialModel materialModel;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                              mainAxisExtent: 292),
                      // shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0)),
                                  child: Image.asset(
                                    "assets/download.jpg",
                                    height: 170,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        snapshot.data![index].price,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .merge(const TextStyle(
                                                fontSize: 16,
                                                color: Colors.blueAccent)),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              materialModel = MaterialModel(
                                                  name: nameController.text,
                                                  price: priceController.text);
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return CardScreen(
                                                    materialModel:
                                                        snapshot.data![index],
                                                  );
                                                },
                                              ));
                                            },
                                            icon:
                                                const Icon(CupertinoIcons.cart),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await DbHelperMaterial.deleteUser(
                                                  snapshot.data![index]);
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                                CupertinoIcons.delete),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ]),
                        );
                      },
                      itemCount: snapshot.data!.length);
                }
              }
              return const Center(child: Text("No notes yet!"));
            }),
            future: DbHelperMaterial.getAllUsers()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddMaterialScreen();
            },
          ));
        },
        // backgroundColor: const Color.fromRGBO(159, 30, 30, 100),
        child: const Icon(
          Icons.add,
          // color: Colors.white,
        ),
      ),
    );
  }
}
