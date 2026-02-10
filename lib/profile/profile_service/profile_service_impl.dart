import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/models/profile_response_dto.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/profile_service.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/api_exception.dart';
import 'package:startup_mvp_starter_flutter/utils/user_document_service.dart';

class ProfileServiceImpl implements ProfileService {
  final UserDocumentService userDocumentService;

  ProfileServiceImpl({required this.userDocumentService});

  @override
  Future<Either<ApiException, ProfileResponseDto?>> getProfile() async {
    try {
      await userDocumentService.ensureUserDocument();
      final snapshot = await userDocumentService.userDocRef.get();
      final data = snapshot.data() as Map<String, dynamic>?;

      if (data == null) {
        return const Right(null);
      }

      final Timestamp? birthdayTimestamp = data['birthday'] as Timestamp?;

      return Right(
        ProfileResponseDto(
          id: userDocumentService.currentUid,
          email: userDocumentService.currentEmail,
          name: data['name'] as String?,
          birthday: birthdayTimestamp?.toDate(),
          phone: data['phone'] as String?,
        ),
      );
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, ProfileResponseDto?>> sendProfile({
    String? name,
    DateTime? birthday,
    String? phone,
  }) async {
    try {
      final Map<String, dynamic> updates = {};
      if (name != null) updates['name'] = name;
      if (birthday != null) updates['birthday'] = Timestamp.fromDate(birthday);
      if (phone != null) updates['phone'] = phone;

      await userDocumentService.userDocRef.update(updates);

      return getProfile();
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }
}
