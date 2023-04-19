import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TermsCheckBox extends StatefulWidget {
  const TermsCheckBox({Key? key}) : super(key: key);

  @override
  State<TermsCheckBox> createState() => _TermsCheckBoxState();
}

class _TermsCheckBoxState extends State<TermsCheckBox> {
  bool isChecked = false;

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
            value: isChecked,
            onChanged: (bool? newValue) {
              setState(() {
                isChecked = newValue ?? false;
              });
            },
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
