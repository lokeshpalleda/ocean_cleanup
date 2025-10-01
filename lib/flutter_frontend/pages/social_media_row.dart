import 'package:flutter/material.dart';

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/instagram.jpeg')),
        SizedBox(width: 10),
        CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/discord.png')),
        SizedBox(width: 10),
        CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/facebook.jpeg')),
        SizedBox(width: 10),
        CircleAvatar(radius: 25, backgroundImage: AssetImage('assets/youtube.jpeg')),
      ],
    );
  }
}
