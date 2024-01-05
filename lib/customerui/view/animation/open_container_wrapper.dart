import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:smartstock_pro/adminui/src/model/product.dart';
import 'package:smartstock_pro/customerui/view/screen/product_detail/product_detail_screen.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    Key? key,
    required this.child,
    required this.product,
  }) : super(key: key);

  final Widget child;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      closedColor: const Color(0xFFE5E6E8),
      transitionType: ContainerTransitionType.fade,
      transitionDuration: const Duration(milliseconds: 750),
      openBuilder: (BuildContext context, VoidCallback _) {
        return ProductDetailScreen(product);
      },
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: child,
        );
      },
    );
  }
}
