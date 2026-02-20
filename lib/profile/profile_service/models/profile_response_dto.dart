import 'dart:convert';

class ProfileResponseDto {
  String? id;
  String? email;
  String? name;
  DateTime? birthday;
  String? phone;
  List<String>? fcmTokens;

  ProfileResponseDto({
    this.id,
    this.email,
    this.name,
    this.birthday,
    this.phone,
    this.fcmTokens,
  });

  factory ProfileResponseDto.fromRawJson(String str) =>
      ProfileResponseDto.fromJson(json.decode(str));

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) =>
      ProfileResponseDto(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        birthday: json["birthday"] == null
            ? null
            : DateTime.parse(json["birthday"]),
        phone: json["phone"],
        fcmTokens: json["fcmTokens"] == null
            ? []
            : List<String>.from(json["fcmTokens"]),
      );
}
