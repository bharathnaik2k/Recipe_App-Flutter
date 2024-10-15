import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app.example.com/RecipeApp/food_items_display.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  final CollectionReference categoryAllitems =
      FirebaseFirestore.instance.collection("all_items");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "View All Items",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              StreamBuilder(
                  stream: categoryAllitems.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> categoryAllitems) {
                    if (categoryAllitems.hasData) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.75,
                          crossAxisCount: 2,
                        ),
                        itemCount: categoryAllitems.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot allItems =
                              categoryAllitems.data!.docs[index];
                          return Column(
                            children: [
                              FoodItemsDisplay(documentSnapshot: allItems),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Iconsax.star1,
                                    size: 15,
                                  ),
                                  Text(
                                      " ${categoryAllitems.data!.docs[index]["rate"]}/5  •  "),
                                  Text(
                                      "${categoryAllitems.data!.docs[index]["reviews"]} Reviews")
                                ],
                              )
                            ],
                          );
                        },
                      );
                    }
                    return const CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
