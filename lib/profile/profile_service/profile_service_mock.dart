import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/models/profile_response_dto.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/profile_service.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/api_exception.dart';

class ProfileServiceMock implements ProfileService {
  ProfileResponseDto _mockProfile = ProfileResponseDto(
    id: '1',
    name: 'Иван Иванов',
    birthday: DateTime(1995, 5, 20),
    email: 'ivan@example.com',
  );

  @override
  Future<Either<ApiException, ProfileResponseDto?>> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return Right(_mockProfile);
  }

  @override
  Future<Either<ApiException, ProfileResponseDto?>> sendProfile({
    String? name,
    DateTime? birthday,
    String? phone,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    _mockProfile = ProfileResponseDto(
      id: _mockProfile.id,
      email: _mockProfile.email,
      name: name ?? _mockProfile.name,
      birthday: birthday ?? _mockProfile.birthday,
      phone: phone ?? _mockProfile.phone,
    );

    return Right(_mockProfile);
  }
}
