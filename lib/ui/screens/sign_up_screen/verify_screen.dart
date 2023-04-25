import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import '../../widgets/chats_screen/start_chat_button.dart';
import '../../widgets/login_screen/otp_code.dart';
import '../login_screen/login_screen.dart';
import '../skeleton_screen.dart';
import 'sign_up_view_model.dart';

class VerifyScreen extends ConsumerStatefulWidget {
  final String email;
  final String password;
  const VerifyScreen({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends ConsumerState<VerifyScreen> {
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
    final signUpViewModel = ref.watch(signUpViewModelProvider);

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
                  "We have sent a verification code to your email ${widget.email}. Please enter the code below to verify your account. If you cannot verify now, please do so later under your profile!",
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: 20),
                if (signUpViewModel.verificationErrorMessage != null)
                  Text(
                    '  Error: ${signUpViewModel.verificationErrorMessage!}',
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                SizedBox(height: 10),
                OTPCode(onCodeEntered: (code) {
                  signUpViewModel.setTwoFACode(code);
                }),
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
                                  print('Resend Now Tapped');
                                  if (signUpViewModel.canResendOTP()) {
                                    signUpViewModel.resendOTP(
                                        widget.email, widget.password);
                                    print('sent');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        content: Text(
                                          'New code has been sent!',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background),
                                        ),
                                      ),
                                    );
                                  } else {
                                    int remainingSeconds =
                                        SignUpViewModel.otpSendIntervalSeconds -
                                            DateTime.now()
                                                .difference(signUpViewModel
                                                    .lastOTPSentTime!)
                                                .inSeconds;
                                    DateTime.now();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        content: Text(
                                          'Please wait $remainingSeconds seconds before resending code.',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background),
                                        ),
                                      ),
                                    );
                                  }
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
            text: 'Verify Account',
            onPressed: () async {
              // Call verifyAccount and check the result
              await signUpViewModel.verifyAccount(widget.email);
              try {
                if (signUpViewModel.getVerificationErrorMessage() == null) {
                  print("Success");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                }
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }
}
