import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import '../../../widgets/chats_screen/start_chat_button.dart';
import '../../../widgets/sign_up_screen/email_input.dart';
import '../../../widgets/sign_up_screen/input_field.dart';
import '../../../widgets/sign_up_screen/password_input.dart';
import '../personal_info_screen.dart';
import 'update_full_name_view_model.dart';

class UpdateFullNameScreen extends ConsumerStatefulWidget {
  const UpdateFullNameScreen({Key? key}) : super(key: key);

  @override
  _UpdateFullNameScreenState createState() => _UpdateFullNameScreenState();
}

class _UpdateFullNameScreenState extends ConsumerState<UpdateFullNameScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtain the view model from the provider
    final updateFullNameViewModel = ref.watch(updateFullNameViewModelProvider);
    // Controllers for full name TextFields
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController confirmFullNameController =
        TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Update Full Name',
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
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              children: [
                Text(
                  'Please enter your full name to be saved to\nyour account!',
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
                  'Full Name',
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
            child: InputField(
              textController: fullNameController,
              hintText: 'Enter Full Name...',
              icon: Ionicons.person_circle,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              children: [
                Text(
                  'Confirm Full Name',
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
            child: InputField(
              textController: confirmFullNameController,
              hintText: 'Confirm Full Name...',
              icon: Ionicons.checkbox,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(height: 25),
          StartChatButton(
            text: 'Update Full Name',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
