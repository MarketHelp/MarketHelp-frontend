import 'package:flutter/material.dart';

class ShopFloatingButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ShopFloatingButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
