import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_project/domain/core/failures/main_failure.dart';
import 'package:netflix_project/domain/new_and_hot/models/new_and_hot_resp/new_and_hot_resp.dart';
import 'package:netflix_project/domain/new_and_hot/new_and_hot_service.dart';

part 'new_and_hot_event.dart';
part 'new_and_hot_state.dart';
part 'new_and_hot_bloc.freezed.dart';

@injectable
class NewAndHotBloc extends Bloc<NewAndHotEvent, NewAndHotState> {
  final NewAndHotService _newAndHotService;
  NewAndHotBloc(this._newAndHotService) : super(NewAndHotState.initial()) {
    /* get new_and_hot 
                   movie data*/

    on<LoadDataInComingSoon>((event, emit) async {
      if (state.comingSoonList.isNotEmpty) {
        emit(
          NewAndHotState(
            comingSoonList: state.comingSoonList,
            everyoneIsWatchingList: state.everyoneIsWatchingList,
            isLoading: false,
            hasError: false,
          ),
        );
        return;
      }
      //send loading to ui

      emit(
        const NewAndHotState(
          comingSoonList: [],
          everyoneIsWatchingList: [],
          isLoading: true,
          hasError: false,
        ),
      );
      //get data from remote
      final result = await _newAndHotService.getNewAndHotMovies();
      final newInitialState = result.fold(
        (MainFailure failure) {
          return const NewAndHotState(
            comingSoonList: [],
            everyoneIsWatchingList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (NewAndHotResp resp) {
          return NewAndHotState(
            comingSoonList: resp.results,
            everyoneIsWatchingList: state.everyoneIsWatchingList,
            isLoading: false,
            hasError: false,
          );
        },
      );
      emit(newInitialState);
    });
    /* get new_and_hot 
                   tv data*/

    on<LoadDataInEveryOneIsWatching>((event, emit) async {
      if (state.everyoneIsWatchingList.isNotEmpty) {
        emit(
          NewAndHotState(
            comingSoonList: state.comingSoonList,
            everyoneIsWatchingList: state.everyoneIsWatchingList,
            isLoading: false,
            hasError: false,
          ),
        );
        return;
      }
      //send loading to ui

      emit(const NewAndHotState(
        comingSoonList: [],
        everyoneIsWatchingList: [],
        isLoading: true,
        hasError: false,
      ));
      //get data from remote
      final result = await _newAndHotService.getNewAndHotTv();

      final newState = result.fold(
        (MainFailure failure) {
          return const NewAndHotState(
              comingSoonList: [],
              everyoneIsWatchingList: [],
              isLoading: false,
              hasError: true);
        },
        (NewAndHotResp resp) {
          return NewAndHotState(
              comingSoonList: state.comingSoonList,
              everyoneIsWatchingList: resp.results,
              isLoading: false,
              hasError: false);
        },
      );
      emit(newState);
    });
  }
}
