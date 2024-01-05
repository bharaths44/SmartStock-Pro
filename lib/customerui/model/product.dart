import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  int price;
  String about;
  bool isAvailable;
  int quantity;
  String image;
  String type;
  int stock;

  Product({
    required this.id,
    required this.stock,
    required this.name,
    required this.price,
    required this.about,
    required this.isAvailable,
    required this.quantity,
    required this.image,
    required this.type,
  });
  factory Product.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'],
      price: data['price'] ?? 0,
      about: data['about'],
      isAvailable: data['isAvailable'] ?? false,
      quantity: data['quantity'] ?? 0,
      image: data['image'],
      type: data['type'],
      stock: data['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "price": price,
      "about": about,
      "isAvailable": isAvailable,
      "image": image,
      "quantity": quantity,
      "type": type,
      "stock": stock,
    };
  }
}
