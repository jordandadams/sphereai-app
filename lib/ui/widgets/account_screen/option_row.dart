import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class OptionRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing; // Optional parameter for the trailing widget
  final VoidCallback?
      onTap; // Optional callback for handling taps on the arrow icon
  const OptionRow(
      {required this.icon, required this.title, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.secondary,),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary,),
            ),
          ),
          // Wrap the trailing widget with InkWell and Container
          trailing != null
              ? InkWell(
                  onTap: onTap,
                  child: Container(
                    width: 35, // Fixed width for alignment
                    alignment: Alignment
                        .centerRight, // Right alignment within the container
                    child: trailing,
                  ),
                )
              : InkWell(
                  onTap: onTap,
                  child: Container(
                    width: 40, // Fixed width for alignment
                    alignment: Alignment
                        .centerRight, // Right alignment within the container
                    child: Icon(Ionicons.arrow_forward, size: 20, color: Theme.of(context).colorScheme.secondary,),
                  ),
                ),
        ],
      ),
    );
  }
}
