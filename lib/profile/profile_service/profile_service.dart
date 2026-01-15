import 'package:fpdart/fpdart.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/models/profile_response_dto.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/api_exception.dart';

abstract class ProfileService {
  Future<Either<ApiException, ProfileResponseDto?>> getProfile();
  Future<Either<ApiException, ProfileResponseDto?>> sendProfile({
    String? name,
    DateTime? birthday,
    String? phone,
  });
}
