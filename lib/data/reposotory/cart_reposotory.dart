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
    // ignore: avoid_function_literals_in_foreach_calls
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList("cart-list", cart);
    getCartList();
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
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey("cart-list")) {
      carts = sharedPreferences.getStringList("cart-list")!;
    }
    List<CartModel> cartList = [];
    // ignore: avoid_function_literals_in_foreach_calls
    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    //sharedPreferences.remove("cart-history-list");
    // sharedPreferences.remove("cart-list");
    cartHistory = [];
    if (sharedPreferences.containsKey("cart-history-list")) {
      cartHistory = sharedPreferences.getStringList("cart-history-list")!;
    }

    List<CartModel> cartListHistory = [];
    // ignore: avoid_function_literals_in_foreach_calls
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));

    return cartListHistory;
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove('cart-list');
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove("cart-history-list");
  }
}
