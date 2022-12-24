import 'package:flutter/material.dart';

class Attraction {
  String id;
  String name;
  String image;
  List<dynamic> images = [];
  String description;
  String shortDescription; // validate this data use location instant
  String location;
  double latitude;
  double longitude;

  // Constructor
  Attraction({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.images,
  });

  Attraction copy(
          {String? id,
          String? cover_image,
          List<dynamic>? images,
          String? name,
          String? long_description,
          String? short_description,
          String? location,
          double? latitude,
          double? longitude}) =>
      Attraction(
        id: id ?? this.id,
        image: cover_image ?? this.image,
        images: images ?? this.images,
        name: name ?? this.name,
        description: long_description ?? this.description,
        location: location ?? this.location,
        shortDescription: short_description ?? this.shortDescription,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  static Attraction fromJson(Map<String, dynamic> json) => Attraction(
      id: json['id'] ?? '',
      image: json['cover_image'] ?? '',
      images: json['images'] ?? [],
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
        'longitude': longitude,
        'images': images,
      };
}
