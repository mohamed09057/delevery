import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepository {
  final SharedPreferences sharedPreferences;
  CartRepository({required this.sharedPreferences});
  List<String> cart = [];

  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    var time = DateTime.now().toString();
    cart = [];
    for (var element in cartList) {
      element.time = time;
      return cart.add(jsonEncode(element));
    }
    sharedPreferences.setStringList("cart-list", cart);
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey("cart-list")) {
      carts = sharedPreferences.getStringList("cart-list")!;
    }
    List<CartModel> cartList = [];
    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey("cart-history-list")) {
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList("cart-history-list")!;
    }
    List<CartModel> cartListHistory = [];
    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey("cart-history-list")) {
      cartHistory = sharedPreferences.getStringList("cart-history-list")!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }

    removeCart();
    sharedPreferences.setStringList("cart-history-list", cartHistory);
    //print(getCartHistoryList().length.toString());
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove('cart-list');
  }
}
