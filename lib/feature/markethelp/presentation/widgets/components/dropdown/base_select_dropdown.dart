import 'package:flutter/material.dart';

import 'dropdown_widget.dart';

class BaseSelectDropdown extends StatefulWidget {
  final String name;
  final List<String> values;
  final String initialDropDownHeader;

  const BaseSelectDropdown({
    Key? key,
    required this.name,
    required this.values,
    this.initialDropDownHeader = '',
  }) : super(key: key);

  @override
  State<BaseSelectDropdown> createState() => _BaseSelectDropdownState();
}

class _BaseSelectDropdownState extends State<BaseSelectDropdown>
    with SingleTickerProviderStateMixin {
  late List<DropdownWidget> items;
  late String dropDownHeader;
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _angleAnimation;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    items = widget.values.map((text) => DropdownWidget(text: text)).toList();
    dropDownHeader =
        widget.initialDropDownHeader.isEmpty
            ? widget.name
            : widget.initialDropDownHeader;

    // Set up rotation animation for the chevron icon
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _angleAnimation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    super.dispose();
  }

  void onDropdownEntityTap() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _controller.forward();
        _showOverlay();
      } else {
        _controller.reverse();
        _removeOverlay();
      }
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    _removeOverlay();

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(0, size.height),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6D9F2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFD6C9F2)),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border:
                              index < items.length - 1
                                  ? const Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFD6C9F2),
                                      width: 1,
                                    ),
                                  )
                                  : null,
                        ),
                        child: items[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void setDropdownHeader(Function change) {
    setState(() {
      dropDownHeader = change() ?? widget.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE6D9F2), // Light purple background
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: InkWell(
          onTap: onDropdownEntityTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                RotationTransition(
                  turns: _angleAnimation,
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
