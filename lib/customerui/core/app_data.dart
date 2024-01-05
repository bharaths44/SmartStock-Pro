
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:smartstock_pro/customerui/model/product_category.dart';

class AppData {
  const AppData._();

  static List<ProductCategory> categories = [
    ProductCategory(
      "all",
      true,
      Icons.all_inclusive,
    ),
    ProductCategory(
      "mobile",
      false,
      FontAwesomeIcons.mobileScreenButton,
    ),
    ProductCategory("watch", false, Icons.watch),
    ProductCategory(
      "tablet",
      false,
      FontAwesomeIcons.tablet,
    ),
    ProductCategory(
      "headphone",
      false,
      Icons.headphones,
    ),
    ProductCategory(
      "tv",
      false,
      Icons.tv,
    ),
  ];

  static List<Color> randomColors = [
    const Color(0xFFFCE4EC),
    const Color(0xFFF3E5F5),
    const Color(0xFFEDE7F6),
    const Color(0xFFE3F2FD),
    const Color(0xFFE0F2F1),
    const Color(0xFFF1F8E9),
    const Color(0xFFFFF8E1),
    const Color(0xFFECEFF1),
  ];

  
}
