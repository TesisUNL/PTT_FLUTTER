class User {
  String id;
  String image;
  String name;
  String email;
  String phone;

  // Constructor
  User({
    required this.id,
    required this.image,
    required this.name,
    required this.email,
    required this.phone,
  });

  User copy({
    String? id,
    String? imagePath,
    String? name,
    String? phone,
    String? email,
    String? about,
  }) =>
      User(
        id: id ?? this.id,
        image: imagePath ?? image,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        image: json['imageUrl'] ??
            'https://img.freepik.com/free-icon/user_318-804790.jpg?w=2000',
        name: json['name'],
        email: json['email'],
        phone: json['phone_number'] ?? 'not phone number found',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'imagePath': image,
        'name': name,
        'email': email,
        'phone': phone,
      };
}
