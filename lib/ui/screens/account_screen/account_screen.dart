import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../../states/auth_state.dart';
import '../../../states/theme_mode_state.dart';
import '../../widgets/account_screen/option_row.dart';
import '../../widgets/account_screen/section_title.dart';
import '../../../states/user_profile_state.dart';
import '../auth_screen/auth_screen.dart';
import '../personal_info_screen/personal_info_screen.dart';
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

    // Access the current UserProfile
    final userProfile = ref.watch(userProfileStateProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold),
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
                  backgroundImage: AssetImage('assets/img/logo.png'),
                  radius: 40,
                ),

                // Padding for spacing
                Padding(padding: EdgeInsets.symmetric(horizontal: 15)),

                // Use Expanded here
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'User Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Text(
                        userProfile?.email ?? '',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),

                // Padding for spacing
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),

                // Icon for the arrow
                InkWell(
                  onTap: () {
                    accountViewModel.onArrowTap();
                  },
                  child: Icon(
                    Ionicons.arrow_forward,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            SectionTitle(title: 'General'),
            SizedBox(height: 15),
            OptionRow(
              icon: Ionicons.person_outline,
              title: 'Personal Info',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonalInfoScreen()));
              },
            ),
            SizedBox(height: 13),
            OptionRow(
              icon: Ionicons.shield_outline,
              title: 'Security',
              onTap: () {
                accountViewModel.onArrowTap();
              },
            ),
            OptionRow(
              icon: Ionicons.eye_outline,
              title: 'Dark Mode',
              trailing: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  // Listen to the themeProvider to get the current theme mode
                  final themeState = ref.watch(themeProvider);
                  return Switch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    value: themeState.themeMode ==
                        ThemeMode.dark, // Check if current theme mode is dark
                    onChanged: (bool value) {
                      // Toggle the theme mode based on the current value
                      themeState.setThemeMode(
                          value ? ThemeMode.dark : ThemeMode.light);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 5),
            SectionTitle(title: 'About'),
            SizedBox(height: 15),
            OptionRow(
              icon: Ionicons.help_outline,
              title: 'Help Center',
              onTap: () {
                accountViewModel.onArrowTap();
              },
            ),
            SizedBox(height: 13),
            OptionRow(
              icon: Ionicons.lock_closed_outline,
              title: 'Privacy Policy',
              onTap: () {
                accountViewModel.onArrowTap();
              },
            ),
            SizedBox(height: 13),
            OptionRow(
              icon: Ionicons.information_circle_outline,
              title: 'About SphereAI',
              onTap: () {
                accountViewModel.onArrowTap();
              },
            ),
            SizedBox(height: 13),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                // Move the InkWell to wrap the entire row
                onTap: () async {
                  await ref.read(authStateProvider.notifier).logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Ionicons.log_out_outline,
                      size: 18,
                      color: Colors.red,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                    Container(
                      width: 35, // Fixed width for alignment
                      alignment: Alignment
                          .centerRight, // Right alignment within the container
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
