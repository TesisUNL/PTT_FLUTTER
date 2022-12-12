class Attraction {
  String name;
  String image;
  String description;
  String shortDescription; // validate this data use location instant
  String location;
  double latitude;
  double longitude;

  // Constructor
  Attraction({
    required this.image,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  Attraction copy(
          {String? cover_image,
          String? name,
          String? long_description,
          String? short_description,
          String? location,
          double? latitude,
          double? longitude}) =>
      Attraction(
        image: cover_image ?? this.image,
        name: name ?? this.name,
        description: long_description ?? this.description,
        location: location ?? this.location,
        shortDescription: short_description ?? this.shortDescription,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  static Attraction fromJson(Map<String, dynamic> json) => Attraction(
      image: json['cover_image'] ?? '',
      name: json['name'] ?? '',
      description: json['long_description'] ?? '',
      shortDescription: json['short_description'] ?? '',
      location: json['canton'] ?? '',
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0);

  static List<Attraction> fromJsonList(List<dynamic> jsonList) => jsonList
      .map((attractionData) => Attraction.fromJson(attractionData))
      .toList();

  Map<String, dynamic> toJson() => {
        'cover_image': image,
        'long_description': description,
        'short_description': shortDescription,
        'location': location,
        'name': name,
        'latitude': latitude,
        'longitude': longitude
      };
}
