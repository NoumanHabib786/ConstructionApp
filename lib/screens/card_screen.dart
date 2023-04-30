import 'package:flutter/material.dart';
import 'package:flutter_application_12/models/material_model.dart';

class CardScreen extends StatefulWidget {
  final MaterialModel? materialModel;
  const CardScreen({super.key, this.materialModel});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    if (widget.materialModel != null) {
      nameController.text = widget.materialModel!.name;
      priceController.text = widget.materialModel!.price;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD TO CART',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamed(context, 'mainScreen');
          },
        ),
        titleSpacing: 20,
        elevation: 5,
        centerTitle: true,
        actions: const <Widget>[Icon(Icons.add_shopping_cart, size: 30)],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 50, left: 50),
            child: TextField(
              controller: nameController,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 80,
            ),
            width: 280,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Price",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: const Text(
                                        "Are you sure you want to order?"),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Yes"),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("No")),
                                        ],
                                      )
                                    ]);
                              });
                        },
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.deepOrange),
                        ),
                        child: const Text(
                          "Order Now",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: TextField(
                    controller: priceController,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
