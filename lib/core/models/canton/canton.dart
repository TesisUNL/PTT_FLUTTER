class Canton {
  String name;
  String description;
  String flag_image;
  String presentation_video;

  // Constructor
  Canton({
    required this.name,
    required this.description,
    required this.flag_image,
    required this.presentation_video,
  });

  Canton copy({
    String? name,
    String? description,
    String? flag_image,
    String? presentation_video,
  }) =>
      Canton(
        name: name ?? this.name,
        description: description ?? this.description,
        flag_image: flag_image ?? this.flag_image,
        presentation_video: presentation_video ?? this.presentation_video,
      );

  static Canton fromJson(Map<String, dynamic> json) => Canton(
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        flag_image: json['flag_image'] ?? '',
        presentation_video: json['presentation_video'] ?? '',
      );

  static List<Canton> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((cantonData) => Canton.fromJson(cantonData)).toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'flag_image': flag_image,
        'presentation_video': presentation_video
      };
}
