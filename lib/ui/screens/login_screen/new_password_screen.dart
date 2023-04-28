import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import '../../widgets/chats_screen/start_chat_button.dart';
import '../../widgets/sign_up_screen/password_input.dart';
import '../auth_screen/auth_screen.dart';
import 'login_screen.dart';
import 'new_password_view_model.dart';

class NewPasswordScreen extends ConsumerStatefulWidget {
  final String resetToken;
  const NewPasswordScreen({Key? key, required this.resetToken}) : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends ConsumerState<NewPasswordScreen> {
  // Controllers
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtain the view model from the provider
    final newPasswordViewModel = ref.watch(newPasswordViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Password Reset',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
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
            // Use PageRouteBuilder to define custom transition
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration:
                    Duration(milliseconds: 100), // Transition duration
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AuthScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // Define right-to-left transition using Tween and SlideTransition
                  var begin = Offset(1.0, 0.0);
                  var end = Offset.zero;
                  var tween = Tween(begin: begin, end: end);
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create New Password 🔒',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Create your new password! Make sure it is strong so no one can gain access to your account!",
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          if (newPasswordViewModel.newPasswordErrorMessage != null)
            Text(
              '  Error: ${newPasswordViewModel.newPasswordErrorMessage!}',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              children: [
                Text(
                  'New Password',
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
            child: PasswordInput(passwordController: newPasswordController),
          ),
          SizedBox(height: 20),
          if (newPasswordViewModel.confirmNewPasswordErrorMessage != null)
            Text(
              '  Error: ${newPasswordViewModel.confirmNewPasswordErrorMessage!}',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              children: [
                Text(
                  'Confirm New Password',
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
            child:
                PasswordInput(passwordController: confirmNewPasswordController),
          ),
          SizedBox(height: 40),
          StartChatButton(
            text: 'Confirm',
            onPressed: () async {
              List<Map<String, String>>? errors =
                  await newPasswordViewModel.changePassword(
                      widget.resetToken, newPasswordController.text, confirmNewPasswordController.text);
              print(errors);
              if (errors == null) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              } else {
                // Display error messages if any
                String errorMessage = '';
                if (newPasswordViewModel.newPasswordErrorMessage != null) {
                  errorMessage += newPasswordViewModel.newPasswordErrorMessage! + '\n';
                }
                if (newPasswordViewModel.confirmNewPasswordErrorMessage != null) {
                  errorMessage += newPasswordViewModel.confirmNewPasswordErrorMessage!;
                }
                print(errorMessage.trim());
              }
            },
          ),
        ],
      ),
    );
  }
}
