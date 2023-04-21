import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import '../../../states/auth_state.dart';
import '../../widgets/chats_screen/start_chat_button.dart';
import '../../widgets/sign_up_screen/email_input.dart';
import '../../widgets/sign_up_screen/password_input.dart';
import '../../widgets/sign_up_screen/terms_checkbox.dart';
import '../skeleton_screen.dart';
import 'complete_profile_screen.dart';
import '../login_screen/login_screen.dart';
import 'sign_up_view_model.dart';
import 'verify_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  // Controllers for email and password TextFields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtain the view model from the provider
    final signUpViewModel = ref.watch(signUpViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Create Account',
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Ionicons.arrow_back,
            color: Theme.of(context).colorScheme.secondary,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              children: [
                Text(
                  'Hello there 👋',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              children: [
                Text(
                  'Please enter your email & password to create\nan account.',
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: EmailInput(emailController: emailController),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              children: [
                Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: PasswordInput(passwordController: passwordController),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
            child: TermsCheckBox(),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              children: [
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center-align the row content
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      TextSpan(
                        text: 'Log in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle the "Log in" tap here
                            print('Log in tapped');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
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
              ],
            ),
          ),
          SizedBox(height: 25),
          StartChatButton(
            text: 'Create Account',
            onPressed: () async {
              // Call the registerAccount method from the view model.
              bool success = await signUpViewModel.registerAccount(
                  emailController.text, passwordController.text);
              if (success) {
                // Navigate to the desired screen if registration succeeded.
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VerifyScreen(email: emailController.text)),
                  (Route<dynamic> route) => false,
                );
              } else {
                print(!success);
                // Handle registration failure (e.g., show an error message).
              }
            },
          ),
        ],
      ),
    );
  }
}
