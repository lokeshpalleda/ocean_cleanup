class EventModel {
  final String id;
  final String title;
  final String date;
  final String imageUrl;
  final String description;
  final double latitude;
  final double longitude;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'],
      title: json['title'],
      date: json['date'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      latitude: double.tryParse(json['location']['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['location']['longitude'].toString()) ?? 0.0,
    );
  }
}
