import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:startup_mvp_starter_flutter/main/main/models/startup_model.dart';
import 'package:startup_mvp_starter_flutter/main/main_details/models/startup_details_model.dart';
import 'package:startup_mvp_starter_flutter/main/service/main_service.dart';
import 'package:startup_mvp_starter_flutter/main/service/models/startup_details_model_firestore.dart';
import 'package:startup_mvp_starter_flutter/main/service/models/startup_model_firestore.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/api_exception.dart';
import 'package:startup_mvp_starter_flutter/utils/shared/shared_storage.dart';

class MainServiceImpl extends MainService {
  final SharedStorage sharedStorage;

  MainServiceImpl({required this.sharedStorage});

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
    final doc = await await FirebaseFirestore.instance
        .collection('startups')
        .doc(startupId)
        .get();

    return Right(StartupDetailsModelFirestore.fromDocument(doc));
  }

  @override
  Future<Either<ApiException, List<String>?>> getFavoriteIds() async {
    return Right(await sharedStorage.getFavoriteIds());
  }
}
