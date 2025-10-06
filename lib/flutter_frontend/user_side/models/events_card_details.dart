class Event {
  final String name;
  final String image;
  final String date;

  Event({required this.name, required this.image, required this.date});
}

List<Event> events = [
  Event(name: 'Beach Cleanup', image: 'assets/beach_cleanup.jpeg', date: 'aug 15'),
  Event(name: 'Awareness Campaign', image: 'assets/plastic_free_drive.jpeg', date: 'oct 2'),
  Event(name: 'Ocean CleanUp', image: 'assets/theocean.jpeg', date: 'nov 21'),
];
