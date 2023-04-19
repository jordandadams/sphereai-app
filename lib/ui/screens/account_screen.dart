import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../widgets/account_screen/option_row.dart';
import '../widgets/account_screen/section_title.dart';
import '../widgets/ai_assistant_screen/custom_carousel.dart';
import 'account_view_model.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtain the view model from the provider
    final accountViewModel = ref.watch(accountViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Circle Avatar (Profile Picture)
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/img/logo.png'), // Replace with actual profile image path
                  radius: 40,
                ),

                // Padding for spacing
                Padding(padding: EdgeInsets.symmetric(horizontal: 15)),

                // Column for displaying user's name and email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'User Name',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'user@example.com',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),

                // Padding for spacing
                Padding(padding: EdgeInsets.symmetric(horizontal: 40)),

                // Icon for the arrow
                Icon(Ionicons.arrow_forward, size: 20),
              ],
            ),

            // General section title
            SizedBox(height: 25),
            SectionTitle(title: 'General'),
            SizedBox(height: 15),
            // Personal Info
            OptionRow(
              icon: Ionicons.person_outline,
              title: 'Personal Info',
              onTap: () {
                accountViewModel.onArrowTap();
              },
            ),
            SizedBox(height: 13),
            // Security
            OptionRow(
              icon: Ionicons.shield_outline,
              title: 'Security',
              onTap: () {
                accountViewModel.onArrowTap();
              },
            ),
            // Dark Mode
            OptionRow(
              icon: Ionicons.eye_outline,
              title: 'Dark Mode',
              trailing: Switch(
                value: accountViewModel
                    .isDarkMode, // Get the value from the view model
                onChanged: (bool value) {
                  accountViewModel
                      .toggleDarkMode(); // Toggle the value using the view model
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
