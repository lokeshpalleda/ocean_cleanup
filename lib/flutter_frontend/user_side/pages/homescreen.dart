import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';
import 'card_event_home.dart';
import 'social_media_row.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List<EventModel> events = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.1.39:3000/api/admin/history"), // ⚠️ Replace with your IPv4
      );
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        setState(() {
          events = data.map((e) => EventModel.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching events: $e");
    }
  }

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
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (events.isEmpty)
            const Center(
              child: Text(
                "No posts yet",
                style: TextStyle(fontSize: 22, color: Colors.blueGrey),
              ),
            )
          else
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Up Coming Events',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 26),
                  ),
                  const SizedBox(height: 20),
                  EventCarousel(
                    currentIndex: currentIndex,
                    events: events,
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
