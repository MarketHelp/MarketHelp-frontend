import 'package:flutter/material.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/components/header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(screenTitle: "Настройки", withSettings: false),
      body: Container(
        color: Colors.grey[50],
        child: Center(
          // Wrap with Center for vertical centering
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Changed from center to start
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Smaller top space to move everything higher
              const SizedBox(
                height: 40,
              ), // Fixed small space instead of flexible spacer
              // Profile section with bigger icon
              Container(
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
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'login',
                      style: TextStyle(
                        fontSize: 20, // Slightly larger text
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // More space between profile and menu items
              const SizedBox(height: 20),

              // Menu items - Wrapped in SizedBox to constrain width
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: _buildMenuItem(
                  context,
                  'Магазины',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/shops',
                      arguments: {'isMainScreen': false},
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: _buildMenuItem(context, 'Инфографики', onTap: () {}),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: _buildMenuItem(context, 'Профиль', onTap: () {}),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: _buildMenuItem(
                  context,
                  'Тариф',
                  onTap: () {},
                  trailing: 'Базовый',
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: _buildMenuItem(
                  context,
                  'Язык',
                  onTap: () {},
                  trailing: 'Русский',
                ),
              ),

              // Increase bottom space to push everything up
              const Spacer(flex: 3), // Increased from flex: 1
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title, {
    required Function() onTap,
    String? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF8e44ad),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailing != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  trailing,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            const Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
