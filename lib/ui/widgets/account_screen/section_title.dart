import 'package:flutter/material.dart';

// Custom widget for section title
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 138, 138, 138)),
        ),
        SizedBox(width: 10), // For spacing between text and line
        Expanded(
          child: Divider(
            color: Color.fromARGB(255, 143, 143, 143),
            thickness: 0.2,
            height: 10,
          ),
        ),
      ],
    );
  }
}
