class Canton {
  String name;
  String description;

  // Constructor
  Canton({
    required this.name,
    required this.description,
  });

  Canton copy({
    String? name,
    String? description,
  }) =>
      Canton(
        name: name ?? this.name,
        description: description ?? this.description,
      );

  static Canton fromJson(Map<String, dynamic> json) => Canton(
        name: json['name'] ?? '',
        description: json['description'] ?? '',
      );

  static List<Canton> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((cantonData) => Canton.fromJson(cantonData)).toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
      };
}
