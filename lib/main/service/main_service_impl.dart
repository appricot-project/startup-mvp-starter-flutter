import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:startup_mvp_starter_flutter/main/main/models/startup_model.dart';
import 'package:startup_mvp_starter_flutter/main/main_details/models/startup_details_model.dart';
import 'package:startup_mvp_starter_flutter/main/service/main_service.dart';
import 'package:startup_mvp_starter_flutter/main/service/models/startup_details_model_firestore.dart';
import 'package:startup_mvp_starter_flutter/main/service/models/startup_model_firestore.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/api_exception.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';
import 'package:startup_mvp_starter_flutter/utils/user_document_service.dart';

class MainServiceImpl extends MainService {
  final UserDocumentService userDocumentService;
  final SharedStorage sharedStorage;

  MainServiceImpl({
    required this.userDocumentService,
    required this.sharedStorage,
  });

  @override
  Future<Either<ApiException, List<StartupModel>>> getStartups() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('startups')
        .orderBy('createdAt', descending: true)
        .get();

    return Right(
      querySnapshot.docs
          .map((doc) => StartupModelFirestore.fromDocument(doc))
          .toList(),
    );
  }

  @override
  Future<Either<ApiException, StartupDetailsModel?>> getStartupDetails(
    String startupId,
  ) async {
    final doc = await FirebaseFirestore.instance
        .collection('startups')
        .doc(startupId)
        .get();

    return Right(StartupDetailsModelFirestore.fromDocument(doc));
  }

  @override
  Future<Either<ApiException, List<String>?>> getFavoriteIds() async {
    if (userDocumentService.currentUser == null) {
      return Right(await sharedStorage.getFavoriteIds());
    }
    try {
      await userDocumentService.ensureUserDocument();
      final snapshot = await userDocumentService.userDocRef.get();
      final data = snapshot.data() as Map<String, dynamic>?;
      final List<dynamic> ids = data?['favoriteIds'] ?? [];
      return Right(ids.cast<String>());
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> addFavoriteId(String id) async {
    if (userDocumentService.currentUser == null) {
      await sharedStorage.addFavoriteId(id);
      return const Right(null);
    }
    try {
      await userDocumentService.ensureUserDocument();
      await userDocumentService.userDocRef.update({
        'favoriteIds': FieldValue.arrayUnion([id]),
      });
      return const Right(null);
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> removeFavoriteId(String id) async {
    if (userDocumentService.currentUser == null) {
      await sharedStorage.removeFavoriteId(id);
      return const Right(null);
    }
    try {
      await userDocumentService.userDocRef.update({
        'favoriteIds': FieldValue.arrayRemove([id]),
      });
      return const Right(null);
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }
}
