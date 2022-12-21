class TouristRoute {
  String id;
  bool isUserRoute;
  String name;
  int views;
  int pathLenght;

  // Constructor
  TouristRoute({
    required this.id,
    required this.isUserRoute,
    required this.name,
    required this.views,
    this.pathLenght = 0,
  });

  TouristRoute copy({
    String? name,
    String? description,
  }) =>
      TouristRoute(
        id: id,
        isUserRoute: isUserRoute,
        name: name ?? this.name,
        views: views,
        pathLenght: pathLenght,
      );

  static TouristRoute fromJson(Map<String, dynamic> json) => TouristRoute(
        id: json['id'] ?? '',
        isUserRoute: json['isUserRoute'] ?? false,
        name: json['name'] ?? '',
        views: json['views'] ?? 0,
      );

  static List<TouristRoute> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((routeData) => TouristRoute.fromJson(routeData)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'isUserRoute': isUserRoute,
        'name': name,
        'views': views,
      };
}
