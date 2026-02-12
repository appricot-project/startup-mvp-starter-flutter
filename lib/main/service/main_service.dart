import 'package:fpdart/fpdart.dart';
import 'package:startup_mvp_starter_flutter/main/main/models/startup_model.dart';
import 'package:startup_mvp_starter_flutter/main/main_details/models/startup_details_model.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/api_exception.dart';

abstract class MainService {
  Future<Either<ApiException, List<StartupModel>>> getStartups();
  Future<Either<ApiException, StartupDetailsModel?>> getStartupDetails(String startupId);
  Future<Either<ApiException, List<String>?>> getFavoriteIds();
  Future<Either<ApiException, void>> addFavoriteId(String id);
  Future<Either<ApiException, void>> removeFavoriteId(String id);
}
