import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String screenTitle;

  const Header({Key? key, required this.screenTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(screenTitle),
      centerTitle: true,
      backgroundColor: Colors.deepPurpleAccent,
      foregroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
