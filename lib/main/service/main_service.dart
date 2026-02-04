import 'package:fpdart/fpdart.dart';
import 'package:startup_mvp_starter_flutter/main/service/models/startup_dto.dart';
import 'package:startup_mvp_starter_flutter/utils/rest_client/api_exception.dart';

abstract class MainService {
  Future<Either<ApiException, List<StartupDto>>> getStartups();
  Future<Either<ApiException, StartupDto?>> getStartupDetails(String startupId);
  Future<Either<ApiException, List<String>?>> getFavoriteIds();
}
