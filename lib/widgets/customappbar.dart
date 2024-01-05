import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double titleSize;
  final FontWeight titleWeight;
  final bool leading;
  const CustomAppBar({
    super.key,
    required this.title,
    this.titleSize = 35.0,
    this.titleWeight = FontWeight.w300,
    this.leading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: leading,
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: titleSize,
          fontWeight: titleWeight,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
