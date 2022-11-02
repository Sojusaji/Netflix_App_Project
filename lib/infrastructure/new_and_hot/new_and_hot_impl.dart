import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_project/domain/core/api_end_points.dart';
import 'package:netflix_project/domain/new_and_hot/models/new_and_hot_resp/new_and_hot_resp.dart';
import 'package:netflix_project/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_project/domain/new_and_hot/new_and_hot_service.dart';

@LazySingleton(as: NewAndHotService)
class NewAndHotImplementation implements NewAndHotService {
  @override
  Future<Either<MainFailure, NewAndHotResp>> getNewAndHotMovies() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.newAndHotMovie);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = NewAndHotResp.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (_) {
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, NewAndHotResp>> getNewAndHotTv() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.newAndHotTv);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = NewAndHotResp.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (_) {
      return const Left(MainFailure.clientFailure());
    }
  }
}
