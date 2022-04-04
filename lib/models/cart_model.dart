import 'package:deleveryapp/models/popular_product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  int? quantity;
  bool? isExsist;
  String? img;
  String? time;
  ProductModel? product;
  CartModel({
    this.id,
    this.img,
    this.name,
    this.price,
    this.isExsist,
    this.quantity,
    this.time,
    this.product,
  });
  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExsist = json['isExsist'];
    time = json['time'];
    product = ProductModel.fromJson(json['product']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'img': img,
      'quantity': quantity,
      'isExsist': isExsist,
      'time': time,
      'product': product!.toJson(),
    };
  }
}
