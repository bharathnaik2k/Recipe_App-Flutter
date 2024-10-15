import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app.example.com/RecipeApp/food_items_details.dart';
import 'package:recipe_app.example.com/RecipeApp/provider/favorite_provider.dart';
import 'package:recipe_app.example.com/RecipeApp/provider/q_provider.dart';

class FoodItemsDisplay extends StatelessWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const FoodItemsDisplay({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final q1 = Provider.of<QuantityProvider>(context);
    return GestureDetector(
      onTap: () {
        q1.Curentquantity = 1;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return FoodItemDetailsScreen(documentSnapshot: documentSnapshot);
            },
          ),
        );
      },
      child: Hero(
        tag: "hai",
        child: Container(
          margin: const EdgeInsets.only(right: 5, left: 5),
          height: 200,
          width: 230,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.5, 3],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(documentSnapshot["image"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              documentSnapshot["name"],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.flash_15,
                                color: Colors.red,
                                size: 14,
                              ),
                              Text(
                                "${documentSnapshot["cal"]} Cal • ",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const Icon(
                                Iconsax.clock,
                                size: 14,
                                color: Colors.white,
                              ),
                              Text(
                                "${documentSnapshot["time"]} Min",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 8),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      provider.toggleFavorite(documentSnapshot);
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(
                        provider.isExist(documentSnapshot)
                            ? Iconsax.heart5
                            : Iconsax.heart,
                        color: provider.isExist(documentSnapshot)
                            ? Colors.red
                            : Colors.blue,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
