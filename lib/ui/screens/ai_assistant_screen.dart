import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ionicons/ionicons.dart';

import 'ai_assistant_view_model.dart';

class AIAssistantScreen extends ConsumerStatefulWidget {
  const AIAssistantScreen({Key? key}) : super(key: key);

  @override
  _AIAssistantScreenState createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends ConsumerState<AIAssistantScreen> {
  final List<String> emojiList = [
    '🚀', // Rocket emoji
    '🌟', // Star emoji
    '🎉', // Party popper emoji
  ];

  final List<String> headingList = [
    'Heading 1',
    'Heading 2',
    'Heading 3',
  ];

  final List<String> descriptionList = [
    'Description 1',
    'Description 2',
    'Description 3',
  ];

  @override
  Widget build(BuildContext context) {
    // Obtain the view model from the provider
    final aiAssistantViewModel = ref.read(aiAssistantViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'AI Assistant',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Left-align the text and carousel
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                child: Row(
                  children: [
                    Text(
                      'Carousel Heading',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () => {},
                      icon: Icon(Ionicons.arrow_forward),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10), // Spacing between text and carousel
              CarouselSlider.builder(
                itemCount: emojiList.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          emojiList[index],
                          style: TextStyle(fontSize: 50), // Emoji size
                        ),
                        SizedBox(height: 10),
                        Text(
                          headingList[index],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          descriptionList[index],
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 180,
                  autoPlay: false,
                  viewportFraction: 0.5,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  padEnds: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
