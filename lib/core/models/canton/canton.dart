import 'package:ptt_rtmb/core/models/attraction/attraction.dart';

class Canton {
  String name;
  String description;
  String flag;
  String video;

  // Constructor
  Canton({
    required this.name,
    required this.description,
    required this.flag,
    required this.video,
  });

  Canton copy({
    String? name,
    String? description,
  }) =>
      Canton(
        name: name ?? this.name,
        description: description ?? this.description,
        flag: flag,
        video: video,
      );

  static Canton fromJson(Map<String, dynamic> json) => Canton(
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        flag: json['flag'] ?? '',
        video: json['video'] ?? '',
      );

  static List<Canton> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((cantonData) => Canton.fromJson(cantonData)).toList();

  Map<String, dynamic> toJson() =>
      {'name': name, 'description': description, 'flag': flag, 'video': video};
}
