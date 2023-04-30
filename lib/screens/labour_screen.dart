import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_12/screens/add_labour_screen.dart';
import 'package:flutter_application_12/services/db_helper_labour.dart';
import '../models/labour_model.dart';

class LabourScreen extends StatefulWidget {
  const LabourScreen({super.key});

  @override
  State<LabourScreen> createState() => _LabourScreenState();
}

class _LabourScreenState extends State<LabourScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: FutureBuilder(
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 160,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withAlpha(100),
                                    blurRadius: 10.0),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data![index].name,
                                      style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "CBE",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data![index].field,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await DbHelperLabour.deleteUser(
                                            snapshot.data![index]);
                                        setState(() {});
                                      },
                                      icon: const Icon(CupertinoIcons.delete),
                                    )
                                  ],
                                ),
                                Image.asset(
                                  "assets/images.jpg",
                                  height: 100,
                                  width: 100,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.length);
                }
              }
              return const Center(child: Text("No notes yet!"));
            }),
            future: DbHelperLabour.getAllUsers()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const AddLabourScreen();
              },
            ));
          },
          child: const Icon(Icons.add),
        ));
  }
}
