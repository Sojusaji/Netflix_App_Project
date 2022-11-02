part of 'new_and_hot_bloc.dart';

@freezed
class NewAndHotState with _$NewAndHotState {
  const factory NewAndHotState({
    required List<HotAndNewData> comingSoonList,
    required List<HotAndNewData> everyoneIsWatchingList,
    required bool isLoading,
    required bool hasError,
  }) = _NewAndHotState;

  factory NewAndHotState.initial() => const NewAndHotState(
        comingSoonList: [],
        everyoneIsWatchingList: [],
        isLoading: false,
        hasError: false,
      );
}
