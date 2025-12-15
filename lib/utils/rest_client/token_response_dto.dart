import 'dart:convert';

class TokenResponseDto {
  final String? accessToken;
  final String? refreshToken;
  final int? expiresIn;

  TokenResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) {
    return TokenResponseDto(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }

  factory TokenResponseDto.fromRawJson(String str) =>
      TokenResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}
