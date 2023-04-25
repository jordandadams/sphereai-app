import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TermsCheckBox extends StatefulWidget {
  final bool isChecked; // Added parameter
  final ValueChanged<bool?>? onCheckboxChanged; // Added parameter

  const TermsCheckBox({
    Key? key,
    required this.isChecked, // Initialize the isChecked parameter
    required this.onCheckboxChanged, // Initialize the onCheckboxChanged parameter
  }) : super(key: key);

  @override
  State<TermsCheckBox> createState() => _TermsCheckBoxState();
}

class _TermsCheckBoxState extends State<TermsCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        children: [
          Checkbox(
            checkColor: Theme.of(context).colorScheme.background,
            activeColor: Theme.of(context).colorScheme.primary,
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2.0,
            ),
            value: widget.isChecked, // Use the isChecked parameter from the widget
            onChanged: widget.onCheckboxChanged, // Use the onCheckboxChanged parameter from the widget
          ),
          Expanded(
            child: Text(
              "I agree to SphereAI Public Agreement, Terms, & Privacy Policy.",
              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
