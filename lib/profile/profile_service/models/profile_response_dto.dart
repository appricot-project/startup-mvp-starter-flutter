import 'dart:convert';

class ProfileResponseDto {
  String? id;
  String? email;
  String? name;
  DateTime? birthday;
  String? phone;

  ProfileResponseDto({
    this.id,
    this.email,
    this.name,
    this.birthday,
    this.phone,
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
      );
}
