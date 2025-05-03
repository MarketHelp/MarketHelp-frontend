import 'package:flutter/material.dart';

enum SearchBoxType { basic, withSettings }

class SearchBox extends StatelessWidget {
  final String hintText;
  final SearchBoxType type;
  final VoidCallback? onSettingsTap;
  final Function(String)? onSearchChanged;

  const SearchBox._({
    Key? key,
    required this.hintText,
    required this.type,
    this.onSettingsTap,
    this.onSearchChanged,
  }) : super(key: key);

  // Basic search box factory constructor
  factory SearchBox.basic({
    Key? key,
    String hintText = 'Найти товар',
    Function(String)? onSearchChanged,
  }) {
    return SearchBox._(
      key: key,
      hintText: hintText,
      type: SearchBoxType.basic,
      onSearchChanged: onSearchChanged,
    );
  }

  // Search box with settings icon factory constructor
  factory SearchBox.withSettings({
    Key? key,
    String hintText = 'Найти товар',
    VoidCallback? onSettingsTap,
    Function(String)? onSearchChanged,
  }) {
    return SearchBox._(
      key: key,
      hintText: hintText,
      type: SearchBoxType.withSettings,
      onSettingsTap: onSettingsTap,
      onSearchChanged: onSearchChanged,
    );
  }

  // Default constructor now delegates to factory
  factory SearchBox({
    Key? key,
    String hintText = 'Найти магазин',
    bool withSettings = false,
    VoidCallback? onSettingsTap,
    Function(String)? onSearchChanged,
  }) {
    return withSettings
        ? SearchBox.withSettings(
          key: key,
          hintText: hintText,
          onSettingsTap: onSettingsTap,
          onSearchChanged: onSearchChanged,
        )
        : SearchBox.basic(
          key: key,
          hintText: hintText,
          onSearchChanged: onSearchChanged,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black, width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                  isDense: true,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 12, right: 6),
                    child: Icon(Icons.search, color: Colors.black, size: 20),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 35,
                    minHeight: 35,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
          ),
          if (type == SearchBoxType.withSettings)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _buildSettingsButton(),
            ),
        ],
      ),
    );
  }

  Widget _buildSettingsButton() {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.only(right: 0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onSettingsTap,
          child: const Icon(Icons.tune, color: Colors.black, size: 20),
        ),
      ),
    );
  }
}
