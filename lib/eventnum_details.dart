class Eventdetails {
  final String eventname;
  final String eventdate;
  final String eventlocation;
  final String eventdes;
  final String image;
  final double latitu;
  final double longi;

  Eventdetails({
    required this.eventname,
    required this.eventdate,
    required this.eventlocation,
    required this.eventdes,
    required this.image,
    required this.latitu,
    required this.longi
  });
}

List<Eventdetails> eventdetails = [
  Eventdetails(
    eventname: 'Beach CleanUp',
    eventdate: 'july 10',
    eventlocation: 'RK Beach',
    eventdes:
        'eventdes You can customize these based on the actual goals of your project.',
    image: 'assets/beach_cleanup.jpeg',
    latitu: 17.714294,
    longi: 83.323685
  ),
  Eventdetails(
    eventname: 'Awareness Campign',
    eventdate: 'aug 15',
    eventlocation: 'Collector Office',
    eventdes:
        'eventdes You can customize these based on the actual goals of your project.',
    image: 'assets/plastic_free_drive.jpeg',
    latitu: 17.7063,
    longi:  83.3090
  ),
  Eventdetails(
    eventname: 'ocean cleanup',
    eventdate: 'oct 2',
    eventlocation: 'port',
    eventdes:
        'eventdes You can customize these based on the actual goals of your project.',
    image: 'assets/theocean.jpeg',
    latitu: 17.686815,
    longi: 83.218483
  ),
];