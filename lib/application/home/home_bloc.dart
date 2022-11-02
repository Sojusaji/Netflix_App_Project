import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_project/domain/core/failures/main_failure.dart';
import 'package:netflix_project/domain/downloads/i_downloads_repo.dart';
import 'package:netflix_project/domain/downloads/models/downloads.dart';
import 'package:netflix_project/domain/new_and_hot/models/new_and_hot_resp/new_and_hot_resp.dart';
import 'package:netflix_project/domain/new_and_hot/new_and_hot_service.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NewAndHotService _homeService;
  final IDownloadsRepo _downloadService;

  HomeBloc(
    this._homeService,
    this._downloadService,
  ) : super(HomeState.initial()) {
    /*
    
    
    on event get home screen data 
    
    
    */
    on<GetHomeScreenData>((event, emit) async {
//send loading to UI

      emit(state.copyWith(isLoading: true, hasError: false));

//get Data

      final movieResult = await _homeService.getNewAndHotMovies();
      final tvResult = await _homeService.getNewAndHotTv();
      final trendMovieList = await _downloadService.getDownloadsImage();

      //transform data

      emit(movieResult.fold((MainFailure failure) {
        return HomeState(
            patYearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
            stateId: DateTime.now().microsecondsSinceEpoch.toString());
      }, (NewAndHotResp resp) {
        final pastYear = resp.results;

        final dramas = resp.results;

        pastYear.shuffle();
        dramas.shuffle();

        return HomeState(
            stateId: DateTime.now().microsecondsSinceEpoch.toString(),
            patYearMovieList: pastYear,
            trendingMovieList: state.trendingMovieList,
            tenseDramasMovieList: dramas,
            southIndianMovieList: state.southIndianMovieList,
            trendingTvList: state.trendingTvList,
            isLoading: false,
            hasError: false);
      }));

      emit(tvResult.fold((MainFailure failure) {
        return HomeState(
            stateId: DateTime.now().microsecondsSinceEpoch.toString(),
            patYearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true);
      }, (NewAndHotResp resp) {
        final to10List = resp.results;
        to10List.shuffle();

        return HomeState(
            stateId: DateTime.now().microsecondsSinceEpoch.toString(),
            patYearMovieList: state.patYearMovieList,
            trendingMovieList: state.trendingMovieList,
            tenseDramasMovieList: state.tenseDramasMovieList,
            southIndianMovieList: state.southIndianMovieList,
            trendingTvList: to10List,
            isLoading: false,
            hasError: false);
      }));

      emit(trendMovieList.fold((failure) {
        return HomeState(
            stateId: DateTime.now().microsecondsSinceEpoch.toString(),
            patYearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true);
      }, (success) {
        final trendingMovie = success;

        final southIndianMovie = success;

        return HomeState(
            stateId: DateTime.now().microsecondsSinceEpoch.toString(),
            patYearMovieList: state.patYearMovieList,
            trendingMovieList: trendingMovie,
            tenseDramasMovieList: state.tenseDramasMovieList,
            southIndianMovieList: southIndianMovie,
            trendingTvList: state.trendingTvList,
            isLoading: false,
            hasError: false);
      }));

      //send to UI
    });
  }
}
