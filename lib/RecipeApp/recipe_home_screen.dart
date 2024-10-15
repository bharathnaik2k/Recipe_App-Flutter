import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app.example.com/RecipeApp/food_items_display.dart';
import 'package:recipe_app.example.com/RecipeApp/my_icon_button.dart';
import 'package:recipe_app.example.com/RecipeApp/view_all_widget.dart';

class RecipeHomeScreen extends StatefulWidget {
  const RecipeHomeScreen({super.key});

  @override
  State<RecipeHomeScreen> createState() => _RecipeHomeScreenState();
}

class _RecipeHomeScreenState extends State<RecipeHomeScreen> {
  final CollectionReference categorItems =
      FirebaseFirestore.instance.collection("recipe");
  String category = "All";
  var currentindex = 0;
  Query get filterrecipe {
    return FirebaseFirestore.instance
        .collection("all_items")
        .where("category", isEqualTo: category);
  }

  Query get allrecipe {
    return FirebaseFirestore.instance.collection("all_items");
  }

  Query get selectedrecipe {
    return category == "All" ? allrecipe : filterrecipe;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: bottomNaviBar(),
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "What are you\ncooking today",
                      style: TextStyle(
                        wordSpacing: 1,
                        fontWeight: FontWeight.w800,
                        fontSize: 24.0,
                        height: 1,
                        color: Color.fromARGB(255, 24, 70, 151),
                      ),
                    ),
                    const Spacer(),
                    MyIconButton(
                      icon: Iconsax.notification,
                      pressed: () {},
                    )
                  ],
                ),
                const SizedBox(height: 14),
                SearchBar(
                  constraints: const BoxConstraints(minHeight: 48),
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.only(left: 14, right: 14),
                  ),
                  hintText: "Search any recipes...",
                  leading: const Icon(Iconsax.search_normal),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  elevation: const MaterialStatePropertyAll(0),
                ),
                const SizedBox(height: 14),
                Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 24, 70, 151),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Cook the best\nrecipes at home",
                              style: TextStyle(
                                height: 1.1,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 18.0,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text("Explore"),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: -20,
                        child: Image.network(
                          "http://pngimg.com/d/chef_PNG190.png",
                          // errorBuilder: (context, error, stackTrace) {
                          //   return const Icon(Icons.error); // Fallback widget
                          // },
                          // loadingBuilder: (context, child, progress) {
                          //   return progress == null
                          //       ? child
                          //       : const CircularProgressIndicator(); // Loading indicator
                          // },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Category",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                StreamBuilder(
                  stream: categorItems.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            streamSnapshot.data!.docs.length,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  category =
                                      streamSnapshot.data?.docs[index]["name"];
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: category ==
                                          streamSnapshot.data!.docs[index]
                                              ["name"]
                                      ? Colors.blue
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                margin: const EdgeInsets.only(right: 20),
                                child: Container(
                                  // padding: const EdgeInsets.only(
                                  //     right: 14, left: 14, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(streamSnapshot
                                      .data!.docs[index]["name"]
                                      .toString()),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      "Quick & Easy",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const ViewAllScreen();
                          },
                        ));
                      },
                      style: const ButtonStyle(
                          shape: MaterialStatePropertyAll(StadiumBorder())),
                      child: const Text("View All"),
                    )
                  ],
                ),
                StreamBuilder(
                    stream: selectedrecipe.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> recipes =
                            snapshot.data?.docs ?? [];

                        return Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: recipes
                                  .map((e) =>
                                      FoodItemsDisplay(documentSnapshot: e))
                                  .toList(),
                            ),
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

 
}
