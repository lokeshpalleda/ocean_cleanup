import 'package:flutter/material.dart';
import 'package:ocean_clean/flutter_frontend/pages/card_event_home.dart';
import 'package:ocean_clean/flutter_frontend/pages/social_media_row.dart';
import '../models/events_card_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
        title: const Text(
          'Welcome to Ocean Clean',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/background.jpg', fit: BoxFit.fill),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Up Comming Events',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 26),
                ),
                const SizedBox(height: 20),
                EventCarousel(
                  currentIndex: currentIndex,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(events.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentIndex == index ? 12 : 8,
                      height: currentIndex == index ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index ? Colors.blue : Colors.grey,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'To Know About More Events Follow us',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
                const SocialMediaRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
