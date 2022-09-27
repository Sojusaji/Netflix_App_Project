import 'package:dartz/dartz.dart';
import 'package:netflix_project/domain/core/failures/main_failure.dart';
import 'package:netflix_project/domain/search/model/search_resp/search_resp.dart';

abstract class SearchService {
  Future<Either<MainFailure, SearchResp>> SearchMovies({
    required String movieQuery,
  });
}
