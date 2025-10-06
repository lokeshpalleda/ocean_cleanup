import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/event_model.dart';

class Eventnum extends StatelessWidget {
  final EventModel event;
  const Eventnum({super.key, required this.event});

  Future<void> openMap() async {
    final Uri mapUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${event.latitude},${event.longitude}');
    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
        title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/background.jpg', fit: BoxFit.fill),
          ),
          Column(
            children: [
              Image.network(event.imageUrl, height: 250, width: double.infinity, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Title: ${event.title}", style: const TextStyle(fontSize: 20)),
                    Text("Date: ${event.date}", style: const TextStyle(fontSize: 20)),
                    Text("Description: ${event.description}", style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: openMap,
                child: const Text("View Location"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
