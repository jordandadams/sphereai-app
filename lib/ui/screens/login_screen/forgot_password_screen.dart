import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import '../../widgets/chats_screen/start_chat_button.dart';
import '../../widgets/sign_up_screen/email_input.dart';
import 'forgot_password_view_model.dart';
import 'otp_screen.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  // Controllers
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtain the view model from the provider
    final forgotPasswordViewModel = ref.watch(forgotPasswordViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Forgot Password',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset your password 🔑',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Please enter your email and we will send an OTP code in the next step to reset your password.",
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
          if (forgotPasswordViewModel.resetPasswordErrorMessage != null)
            Text(
              'Error: ${forgotPasswordViewModel.resetPasswordErrorMessage!}',
              style: TextStyle(color: Colors.red, fontSize: 13),
            ),
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
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: EmailInput(emailController: emailController),
          ),
          SizedBox(height: 25),
          StartChatButton(
            text: 'Send Code',
            onPressed: () async {
              // Make onPressed async
              bool success = await forgotPasswordViewModel
                  .sendResetCode(emailController.text);
              if (success) {
                // Navigate to OTPScreen on success
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OTPScreen(email: emailController.text),
                  ),
                );
              } else {
                print('failed');
              }
            },
          ),
        ],
      ),
    );
  }
}
