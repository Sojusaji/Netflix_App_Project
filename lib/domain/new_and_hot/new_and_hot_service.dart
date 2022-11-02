import 'package:dartz/dartz.dart';
import 'package:netflix_project/domain/core/failures/main_failure.dart';
import 'package:netflix_project/domain/new_and_hot/models/new_and_hot_resp/new_and_hot_resp.dart';

abstract class NewAndHotService {
  Future<Either<MainFailure, NewAndHotResp>> getNewAndHotMovies();
  Future<Either<MainFailure, NewAndHotResp>> getNewAndHotTv();
}
