import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import '../../widgets/account_screen/option_row.dart';
import '../../widgets/account_screen/section_title.dart';
import 'personal_info_view_model.dart';

class PersonalInfoScreen extends ConsumerStatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends ConsumerState<PersonalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtain the view model from the provider
    final personalInfoViewModel = ref.watch(personalInfoViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Personal Info',
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Padding for spacing
            Padding(padding: EdgeInsets.symmetric(horizontal: 15)),

            OptionRow(
              icon: Ionicons.mail_open_outline,
              title: 'Update Email',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonalInfoScreen()));
              },
            ),
            SizedBox(height: 4),
            SectionTitle(title: ''),
            SizedBox(height: 4),
            OptionRow(
              icon: Ionicons.person_circle_outline,
              title: 'Update Full Name',
              onTap: () {},
            ),
            SizedBox(height: 4),
            SectionTitle(title: ''),
            SizedBox(height: 4),
            OptionRow(
              icon: Ionicons.phone_portrait_outline,
              title: 'Update Phone Number',
              onTap: () {},
            ),
            SizedBox(height: 4),
            SectionTitle(title: ''),
            SizedBox(height: 4),
            OptionRow(
              icon: Ionicons.calendar_number_outline,
              title: 'Update Date of Birth',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
