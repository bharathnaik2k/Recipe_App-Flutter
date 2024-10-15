import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app.example.com/RecipeApp/provider/favorite_provider.dart';
import 'package:recipe_app.example.com/RecipeApp/provider/q_provider.dart';

class FoodItemDetailsScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const FoodItemDetailsScreen({super.key, required this.documentSnapshot});

  @override
  State<FoodItemDetailsScreen> createState() => _FoodItemDetailsScreenState();
}

class _FoodItemDetailsScreenState extends State<FoodItemDetailsScreen> {
  // int cal = 120;
  // int ca = 0;
  // var qutite = 1;
  @override
  void initState() {
    List<int> baseAmouts = widget.documentSnapshot["calore"]
        .map<int>((amouts) => int.parse(amouts.toString()))
        .toList();
    Provider.of<QuantityProvider>(context, listen: false)
        .setBaseIngredents(baseAmouts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final quantity = Provider.of<QuantityProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        focusColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        disabledElevation: 0,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {},
        label: Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 12, horizontal: 100)),
                shape: MaterialStatePropertyAll(StadiumBorder()),
                elevation: MaterialStatePropertyAll(0),
              ),
              child: const Text("Start Cooking"),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () {
                provider.toggleFavorite(widget.documentSnapshot);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  provider.isExist(widget.documentSnapshot)
                      ? Iconsax.heart5
                      : Iconsax.heart,
                  color: provider.isExist(widget.documentSnapshot)
                      ? Colors.red
                      : Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
      body: Hero(
        tag: "hai",
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.documentSnapshot['image'],
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.documentSnapshot["name"]}",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Iconsax.flash_15,
                                size: 14,
                                color: Colors.red,
                              ),
                              Text(" ${widget.documentSnapshot["cal"]} Cal • "),
                              const Icon(
                                Iconsax.clock,
                                size: 14,
                              ),
                              Text(
                                  " ${widget.documentSnapshot["time"]} Min    -    "),
                              const Icon(
                                Iconsax.star1,
                                color: Colors.orange,
                                size: 15,
                              ),
                              Text(" ${widget.documentSnapshot["rate"]}/5  •  "),
                              Text(
                                  "${widget.documentSnapshot["reviews"]} Reviews")
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${widget.documentSnapshot["note"]}",
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                "Quntity",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.4),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                width: 120,
                                height: 45,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            quantity.incrementQuantity();
                                            // setState(() {
                                            //   qutite++;
                                            //   if (ca == 0) {
                                            //     ca = cal + cal;
                                            //   } else {
                                            //     ca = ca + cal;
                                            //   }
                                            // });
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            size: 22,
                                          )),
                                      Text(quantity.curentquantity.toString()),
                                      InkWell(
                                          onTap: () {
                                            quantity.decrementQuantity();
                                            // if (qutite == 1) {
                                            // } else {
                                            //   setState(() {
                                            //     qutite--;
                                            //     if (ca == 0) {
                                            //       ca = cal - cal;
                                            //     } else {
                                            //       ca = ca - cal;
                                            //     }
                                            //   });
                                            // }
                                          },
                                          child: quantity.curentquantity == 1
                                              ? Icon(
                                                  Icons.remove,
                                                  color: Colors.grey.shade300,
                                                )
                                              : const Icon(Icons.remove)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recipe Ingredents",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Calores  ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
        
                          Row(
                            children: [
                              Column(
                                children: widget.documentSnapshot["in_image"]
                                    .map<Widget>(
                                      (imageUrl) => Container(
                                        margin: const EdgeInsets.only(bottom: 8),
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(imageUrl),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              Column(
                                children: widget.documentSnapshot["in_name"]
                                    .map<Widget>(
                                      (name) => Container(
                                        margin: const EdgeInsets.only(bottom: 8),
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child:
                                            Center(child: Text(name.toString())),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const Spacer(),
                              Column(
                                children: quantity.updateIngredents
                                    .map<Widget>(
                                      (calore) => Container(
                                        margin: const EdgeInsets.only(bottom: 8),
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "${calore}gm",
                                          style:
                                              const TextStyle(color: Colors.grey),
                                        )),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          )
                          // ca == 0 ? Text(cal.toString()) : Text(ca.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          width: 40,
                          child: const Center(
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          width: 40,
                          child: const Center(
                            child: Icon(Icons.notifications),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
