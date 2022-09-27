import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:netflix_project/domain/core/api_end_points.dart';
import 'package:netflix_project/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_project/domain/search/model/search_resp/search_resp.dart';
import 'package:netflix_project/domain/search/search_service.dart';

class SearchImpl implements SearchService {
  @override
  Future<Either<MainFailure, SearchResp>> SearchMovies(
      {required String movieQuery}) async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.search,
              queryParameters: ({
                'query': movieQuery,
              }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = SearchResp.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());

      return const Left(MainFailure.clientFailure());
    }
  }
}
