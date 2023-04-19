// start_chat_button.dart

import 'package:flutter/material.dart';

class StartChatButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const StartChatButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity, // Make the button span across the screen horizontally
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 33, 199, 128), // Background color
            foregroundColor: Colors.white, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(vertical: 17), // Vertical padding
          ),
          child: Text(
            'Start Chat',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}