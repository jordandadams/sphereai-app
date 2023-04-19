import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import '../widgets/chats_screen/start_chat_button.dart';
import 'auth_view_model.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtain the view model from the provider
    final authViewModel = ref.watch(authViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16), // Add spacing between the app bar and the logo
          // Add the logo image to the center of the screen with a specified width and height
          Center(
            child: Container(
              width: 200, // Set the desired width of the logo
              height: 200, // Set the desired height of the logo
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
            'Please Login or Sign Up to',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'start chatting with SphereAI now!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          StartChatButton(
            text: 'Login',
            onPressed: () {
              authViewModel.onStartChat();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Color.fromARGB(255, 143, 143, 143),
                    thickness: 0.2,
                    height: 10,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'or',
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(255, 138, 138, 138)),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Divider(
                    color: Color.fromARGB(255, 143, 143, 143),
                    thickness: 0.2,
                    height: 10,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: double
                  .infinity, // Make the button span across the screen horizontally
              child: ElevatedButton(
                onPressed: () {
                  authViewModel.onStartChat();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.surface, // Background color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Rounded corners
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 17), // Vertical padding
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
