import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'attraction.dart';

class MarkerAttraction {
  String name;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoords;

  MarkerAttraction(
      {required this.name,
      required this.address,
      required this.description,
      required this.thumbNail,
      required this.locationCoords});

  MarkerAttraction.fromAttraction(Attraction attraction)
      : name = attraction.name,
        address = attraction.location,
        description = 'Loja, Ecuador' /*attraction.shortDescription*/,
        thumbNail = attraction.image,
        locationCoords = LatLng(attraction.latitude, attraction.longitude);

  static List<MarkerAttraction> fromAttractionList(
      List<Attraction> attractionList) {
    List<MarkerAttraction> marker = [];
    attractionList.forEach((Attraction attractionElement) {
      marker.add(MarkerAttraction.fromAttraction(attractionElement));
    });

    return marker;
  }
}
