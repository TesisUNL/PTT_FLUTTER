
import 'package:ptt_rtmb/core/models/user/user.dart';

class AuthUser {
  User user;
  String accessToken;
  String? refreshToken;

  // Constructor
  AuthUser({
    required this.user,
    required this.accessToken,
    this.refreshToken,
  });

  AuthUser copy({
    User? user,
    String? accessToken,
    String? refreshToken,
  }) =>
      AuthUser(
        user: user ?? this.user,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  static AuthUser fromJson(Map<String, dynamic> json) => AuthUser(
        user: User.fromJson(json["user"]),
        accessToken: json['access_token'],
        refreshToken: json['refresh_token'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}
