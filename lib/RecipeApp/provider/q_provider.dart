import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class QuantityProvider extends ChangeNotifier {
  int Curentquantity = 1;
  List<int> _baseIngredents = [];
  int get curentquantity => Curentquantity;

  void setBaseIngredents(List<int> amouts) {
    _baseIngredents = amouts;
    // notifyListeners();
  }

  List<String> get updateIngredents {
    return _baseIngredents
        .map<String>(
          (amout) => (amout * Curentquantity).toString(),
        )
        .toList();
  }

  void incrementQuantity() {
    Curentquantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (Curentquantity == 1) {
    } else {
      Curentquantity--;
    }
    notifyListeners();
  }

// static FavoriteProvider of(BuildContext context, {bool listen = true}) {
//     return Provider.of<FavoriteProvider>(context, listen: listen);
//   }
}
