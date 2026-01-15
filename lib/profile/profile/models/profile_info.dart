import 'package:equatable/equatable.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/models/profile_response_dto.dart';
import 'package:intl/intl.dart';

class ProfileInfo extends Equatable {
  final String email;
  final String name;
  final String phone;
  final String? birthday;

  ProfileInfo({
    required this.email,
    required this.name,
    required this.phone,
    required this.birthday,
  });

  factory ProfileInfo.fromDto(ProfileResponseDto dto) {
    return ProfileInfo(
      name: dto.name ?? '',
      phone: dto.phone ?? '',
      birthday: dto.birthday == null
          ? null
          : DateFormat('dd.MM.yyyy').format(dto.birthday!),
      email: dto.email ?? '',
    );
  }

  @override
  List<Object?> get props => [email, name, phone, birthday];
}
