import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AccountTile extends StatelessWidget {
  final String login; // Default value for login

  const AccountTile({super.key, this.login = 'Пользователь'});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Container(
            width: 90, // Increased from 60
            height: 90, // Increased from 60
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: ClipOval(
              child: Container(
                color: Colors.white, // Placeholder color
                child: const Icon(
                  Icons.person,
                  size: 60, // Increased icon size
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            login,
            style: const TextStyle(
              fontSize: 20, // Slightly larger text
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
