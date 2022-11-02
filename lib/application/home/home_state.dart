part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required String stateId,
    required List<HotAndNewData> patYearMovieList,
    required List<Downloads> trendingMovieList,
    required List<HotAndNewData> tenseDramasMovieList,
    required List<Downloads> southIndianMovieList,
    required List<HotAndNewData> trendingTvList,
    required bool isLoading,
    required bool hasError,
  }) = _HomeState;
  factory HomeState.initial() => const HomeState(
      patYearMovieList: [],
      trendingMovieList: [],
      tenseDramasMovieList: [],
      southIndianMovieList: [],
      trendingTvList: [],
      isLoading: false,
      hasError: false,
      stateId: '0');
}
