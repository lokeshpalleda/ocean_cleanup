import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/eventnum_details.dart';

class Eventnum extends StatefulWidget {
  final int index;
  const Eventnum({super.key, required this.index});

  @override
  State<Eventnum> createState() => _EventnumState();
}

class _EventnumState extends State<Eventnum> {
  late final Uri mapUrl;
  late final Future<bool> _canLaunchFuture;

  @override
  void initState() {
    super.initState();
    final even = eventdetails[widget.index];
    mapUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=${even.latitu},${even.longi}');
    _canLaunchFuture = canLaunchUrl(mapUrl);
  }

  Future<void> openMap() async {
    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final even = eventdetails[widget.index];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
        foregroundColor: Colors.white,
        title: Text(even.eventname, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/background.jpg', fit: BoxFit.fill),
          ),
          Column(
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight / 3,
                child: Image.asset(even.image, fit: BoxFit.cover),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25),
                      Text('Title: ${even.eventname}', style: TextStyle(fontSize: 24)),
                      SizedBox(height: 5),
                      Text('Date: ${even.eventdate}', style: TextStyle(fontSize: 24)),
                      SizedBox(height: 5),
                      Text('Location: ${even.eventlocation}', style: TextStyle(fontSize: 24)),
                      SizedBox(height: 5),
                      Text('Description: ${even.eventdes}', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
              ),
              FutureBuilder<bool>(
                future: _canLaunchFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData && snapshot.data == true) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: openMap,
                        child: Text('View Location'),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Map cannot be opened on this device.'),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
