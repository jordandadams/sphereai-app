import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../widgets/chats_screen/start_chat_button.dart';
import 'chat_view_model.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtain the view model from the provider
    final chatViewModel = ref.read(chatViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'SphereAI',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.start, // Align children to the start
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16), // Add spacing between the app bar and the logo
          // Add the logo image to the center of the screen with a specified width and height
          Center(
            child: Container(
              width: 300, // Set the desired width of the logo
              height: 300, // Set the desired height of the logo
              child: Image.asset('assets/img/logo.png'),
            ),
          ),
          Text(
            'Welcome to',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'SphereAI 👋',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 33, 199, 128),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 28), // Add spacing between the texts
          Text(
            'Start chatting with SphereAI now!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'You can ask me anything.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          StartChatButton(
            onPressed: () {
              // Invoke the onStartChat method from the view model
              chatViewModel.onStartChat();
            },
          )
        ],
      ),
    );
  }
}
