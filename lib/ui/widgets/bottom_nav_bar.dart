import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../states/widgets/bottom_nav_bar/bottom_nav_bar_state.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? navIndex = ref.watch(bottomNavProvider) as int?;

    return BottomNavigationBar(
      currentIndex: navIndex ?? 0,
      onTap: (int index) {
        ref.read(bottomNavProvider.notifier).setAndPersistValue(index);
      },
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).textTheme.bodySmall!.color,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Ionicons.chatbubble_ellipses_outline),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Ionicons.options),
          label: 'AI Assistant',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Ionicons.time_outline),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Ionicons.person_outline),
          label: 'Account',
        ),
      ],
    );
  }
}
