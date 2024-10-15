import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app.example.com/RecipeApp/provider/favorite_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final favoriteItems = provider.favorite;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text("Favorite Items"),
        centerTitle: true,
      ),
      body: favoriteItems.isEmpty
          ? const Center(
              child: Text("No Any Favorite Items"),
            )
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                String favorite = favoriteItems[index];

                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("all_items")
                      .doc(favorite)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: SizedBox());
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                        child: Text("Error Loading favorite"),
                      );
                    }
                    var favoriteItem = snapshot.data!;
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            width: double.infinity,
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                    
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            favoriteItem['image'],
                                          ),
                                        ),
                                      ),
                                      height: 70,
                                      width: 90,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${favoriteItem["name"]}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Iconsax.flash_15,
                                            size: 14,
                                            color: Colors.red,
                                          ),
                                          Text(
                                              "${favoriteItem["cal"]} Cal  •  "),
                                          const Icon(
                                            Iconsax.clock,
                                            size: 14,
                                          ),
                                          Text(" ${favoriteItem["time"]} Min"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Iconsax.star1,
                                            size: 14,
                                            color: Colors.orange,
                                          ),
                                          Text(
                                              " ${favoriteItem["rate"]}/5  •  "),
                                          Text(
                                              " ${favoriteItem["reviews"]} Reviews"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          provider.toggleFavorite(favoriteItem);
                                        });
                                      },
                                      icon: const Icon(Icons.delete_rounded))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
    );
  }
}
