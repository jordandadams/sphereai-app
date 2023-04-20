import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ionicons/ionicons.dart';

import '../../widgets/ai_assistant_screen/custom_carousel.dart';
import 'ai_assistant_view_model.dart';

class AIAssistantScreen extends ConsumerStatefulWidget {
  const AIAssistantScreen({Key? key}) : super(key: key);

  @override
  _AIAssistantScreenState createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends ConsumerState<AIAssistantScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtain the view model from the provider
    final aiAssistantViewModel = ref.read(aiAssistantViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'AI Assistant',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCarousel(
              carouselHeading: 'Carousel Heading',
              emojiList: [
                '🚀', // Rocket emoji
                '🌟', // Star emoji
                '🎉', // Party popper emoji
              ],
              headingList: [
                'Write an Article',
                'Heading 2',
                'Heading 3',
              ],
              descriptionList: [
                'Generate well-written articles on any topic you want!',
                'Description 2',
                'Description 3',
              ],
            ),
            CustomCarousel(
              carouselHeading: 'Second Carousel',
              emojiList: [
                '📚', // Books emoji
                '💡', // Light bulb emoji
                '🔍', // Magnifying glass emoji
              ],
              headingList: [
                'Second Heading 1',
                'Second Heading 2',
                'Second Heading 3',
              ],
              descriptionList: [
                'Second Description 1',
                'Second Description 2',
                'Second Description 3',
              ],
            ),
            CustomCarousel(
              carouselHeading: 'Third Carousel',
              emojiList: [
                '📚', // Books emoji
                '💡', // Light bulb emoji
                '🔍', // Magnifying glass emoji
              ],
              headingList: [
                'Third Heading 1',
                'Third Heading 2',
                'Third Heading 3',
              ],
              descriptionList: [
                'Third Description 1',
                'Third Description 2',
                'Third Description 3',
              ],
            ),
          ],
        ),
      ),
    );
  }
}
