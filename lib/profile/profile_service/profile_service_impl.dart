import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:startup_mvp_starter_flutter/profile/notification_list/models/notification_model.dart';
import 'package:startup_mvp_starter_flutter/profile/profile_service/models/notification_model_firestore.dart';
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

  Future<Either<ApiException, List<NotificationModel>?>>
  getNotifications() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Left(ApiException('UnauthorizeUser'));
    }

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .where('userId', isEqualTo: user.uid)
          .orderBy('createdAt', descending: true)
          .get();

      final notifications = querySnapshot.docs
          .map((doc) => NotificationModelFirestore.fromDocument(doc))
          .toList();

      return Right(notifications);
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }
}
