import 'package:flutter/material.dart';

class Frontpage extends StatefulWidget {
  const Frontpage({super.key});

  @override
  State<Frontpage> createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/background.jpg', fit: BoxFit.fill),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '🌟 What Is the Use of the Ocean Clean-Up Volunteer App?',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                ),
                SizedBox(height: 20),
                fronttext('🎯 1. Promotes Real Clean-Up Events'),
                fronttext('📝 2. Makes It Easy to Volunteer'),
                fronttext('📍 3. Shows Event Locations Clearly'),
                fronttext('🏆 4. Inspires Others Through Success Stories'),
                fronttext('📢 5. Can Be Expanded'),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }

  Widget fronttext(String text) {
    return Column(
      children: [
        Text(text, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
        SizedBox(height: 20),
      ],
    );
  }
}
