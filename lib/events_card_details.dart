class Event {
  final String name;
  final String image;
  final String date;

  Event({required this.name, required this.image, required this.date});
}

List<Event> events = [
  Event(name: 'Beach Cleanup', image: 'assets/beach_cleanup.jpeg', date: 'july 10'),
  Event(name: 'Awareness Campaign', image: 'assets/plastic_free_drive.jpeg', date: 'aug 15'),
  Event(name: 'Ocean CleanUp', image: 'assets/theocean.jpeg', date: 'oct 2'),
];
