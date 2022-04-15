import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/reposotory/cart_reposotory.dart';
import '../models/cart_model.dart';
import '../models/popular_product_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepository cartRepository;
  CartController({required this.cartRepository});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(ProductModel productModel, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(productModel.id!)) {
      _items.update(productModel.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExsist: true,
            time: DateTime.now().toString(),
            product: productModel);
      });
      if (totalQuantity <= 0) {
        _items.remove(productModel.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(productModel.id!, () {
          return CartModel(
              id: productModel.id,
              name: productModel.name,
              price: productModel.price,
              img: productModel.img,
              quantity: quantity,
              isExsist: true,
              time: DateTime.now().toString(),
              product: productModel);
        });
      } else {
        Get.snackbar("Item count", "You shold add item in the cart",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepository.addToCartList(getItems);
    update();
  }

  bool exiistInCart(ProductModel productModel) {
    if (_items.containsKey(productModel.id!)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel productModel) {
    var quantity = 0;
    if (_items.containsKey(productModel.id!)) {
      _items.forEach((key, value) {
        if (key == productModel.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity = value.quantity! + totalQuantity;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var totalAmount = 0;
    _items.forEach((key, value) {
      totalAmount = value.price! * value.quantity! + totalAmount;
    });
    return totalAmount;
  }

  List<CartModel> storageItems = [];

  List<CartModel> getCartData() {
    setCart = cartRepository.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepository.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepository.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
    //update();
  }

  void addToCartList() {
    cartRepository.addToCartList(getItems);
    update();
  }

  void clearCartHistory() {
    cartRepository.clearCartHistory();
    update();
  }
}
