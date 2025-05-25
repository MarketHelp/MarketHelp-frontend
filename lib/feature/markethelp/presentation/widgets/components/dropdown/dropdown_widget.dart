import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final String text;
  final bool initialSelected;
  final ValueChanged<bool>? onSelectionChanged;

  const DropdownWidget({
    Key? key,
    required this.text,
    this.initialSelected = false,
    this.onSelectionChanged,
  }) : super(key: key);

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late bool selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialSelected;
  }

  // Setter method for the selected state
  void setSelected(bool value) {
    setState(() {
      selected = value;
      // Notify parent about the change
      if (widget.onSelectionChanged != null) {
        widget.onSelectionChanged!(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setSelected(!selected),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? Colors.deepPurpleAccent : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

//example
// bool dropdownSelected = false;

// DropdownWidget(
//   text: 'Option 1',
//   initialSelected: dropdownSelected,
//   onSelectionChanged: (value) {
//     setState(() {
//       dropdownSelected = value;
//     });
//     print('Dropdown selected: $value');
//   },
// )
