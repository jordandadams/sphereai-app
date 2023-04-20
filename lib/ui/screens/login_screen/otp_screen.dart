import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import '../../widgets/chats_screen/start_chat_button.dart';
import '../../widgets/login_screen/otp_code.dart';
import '../skeleton_screen.dart';
import 'new_password_screen.dart';
import 'otp_view_model.dart';

class OTPScreen extends ConsumerStatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  // Create a list of focus nodes for each digit
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  // Function to focus on the next digit TextFormField
  void nextFocus(int index) {
    if (index < focusNodes.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtain the view model from the provider
    final otpViewModel = ref.watch(otpViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Verification',
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
                  'OTP Code Verification 🔐',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "We have sent an OTP code to your email (email will show here). Enter the OTP code below to verify.",
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: 20),
                OTPCode(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Didn't receive an email? ",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            TextSpan(
                              text: 'Resend Now',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle the "Log in" tap here
                                  print('Resend Now Tapped');
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          StartChatButton(
            text: 'Reset Password',
            onPressed: () {
              otpViewModel.onStartChat();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewPasswordScreen()));
            },
          ),
        ],
      ),
    );
  }
}
