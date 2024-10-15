import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];
  List<String> get favorite => _favoriteIds;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FavoriteProvider() {
    loadFavorite();
  }

  void toggleFavorite(DocumentSnapshot product) async {
    String productId = product.id;
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      await _removeFavorite(productId);
    } else {
      _favoriteIds.add(productId);
      await _addFavorite(productId);
    }
    notifyListeners();
  }

  bool isExist(DocumentSnapshot product) {
    return _favoriteIds.contains(product.id);
  }

  Future<void> _addFavorite(String productId) async {
    try {
      await _firestore
          .collection("favoriteItems")
          .doc(productId)
          .set({"isFavorite": true});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _removeFavorite(String productId) async {
    try {
      await _firestore.collection("favoriteItems").doc(productId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadFavorite() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection("favoriteItems").get();
      _favoriteIds = snapshot.docs.map((e) => e.id).toList();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
