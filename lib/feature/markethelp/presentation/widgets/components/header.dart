import 'package:flutter/material.dart';

enum HeaderType { basic, withSettings }

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String screenTitle;
  final HeaderType type;
  final VoidCallback? onSettingsTap;
  final bool showBackButton;

  const Header._({
    Key? key,
    required this.screenTitle,
    required this.type,
    this.onSettingsTap,
    this.showBackButton = true,
  }) : super(key: key);

  // Factory constructor for basic header (no settings)
  factory Header.basic({
    Key? key,
    required String screenTitle,
    bool showBackButton = true,
  }) {
    return Header._(
      key: key,
      screenTitle: screenTitle,
      type: HeaderType.basic,
      showBackButton: showBackButton,
    );
  }

  // Factory constructor for header with settings
  factory Header.withSettings({
    Key? key,
    required String screenTitle,
    VoidCallback? onSettingsTap,
    bool showBackButton = true,
  }) {
    return Header._(
      key: key,
      screenTitle: screenTitle,
      type: HeaderType.withSettings,
      onSettingsTap: onSettingsTap,
      showBackButton: showBackButton,
    );
  }

  // Default constructor delegates to factory constructors
  factory Header({
    Key? key,
    required String screenTitle,
    bool withSettings = false,
    VoidCallback? onSettingsTap,
    bool showBackButton = true,
  }) {
    return withSettings
        ? Header.withSettings(
          key: key,
          screenTitle: screenTitle,
          onSettingsTap: onSettingsTap,
          showBackButton: showBackButton,
        )
        : Header.basic(
          key: key,
          screenTitle: screenTitle,
          showBackButton: showBackButton,
        );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        screenTitle,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFF9966CC), // Purple color from the design
      elevation: 0,
      leading:
          showBackButton
              ? IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 30, // Larger size as shown in the design
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
              : null,
      actions: [
        if (type == HeaderType.withSettings)
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed:
                onSettingsTap ??
                () {
                  Navigator.pushNamed(context, '/settings');
                },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
