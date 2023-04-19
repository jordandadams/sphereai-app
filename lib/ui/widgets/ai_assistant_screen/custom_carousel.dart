import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ionicons/ionicons.dart';

class CustomCarousel extends StatelessWidget {
  final String carouselHeading;
  final List<String> emojiList;
  final List<String> headingList;
  final List<String> descriptionList;

  CustomCarousel({
    required this.carouselHeading,
    required this.emojiList,
    required this.headingList,
    required this.descriptionList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(9, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    carouselHeading,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Ionicons.arrow_forward, color: Theme.of(context).colorScheme.secondary,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            CarouselSlider.builder(
              itemCount: emojiList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        emojiList[index],
                        style: TextStyle(fontSize: 50),
                      ),
                      SizedBox(height: 10),
                      Text(
                        headingList[index],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
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
    );
  }
}
