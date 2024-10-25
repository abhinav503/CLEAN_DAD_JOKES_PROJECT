import 'dart:async';

import 'package:degreed/core/models/api_failure_model.dart';
import 'package:degreed/core/models/search_dad_joke_request_model.dart';
import 'package:degreed/core/ui/atoms/pagination_controller.dart';
import 'package:degreed/features/home/domain/entities/search_dad_joke_results_entity.dart';
import 'package:degreed/features/home/domain/usecase/get_search_dad_jokes_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:degreed/core/models/no_param_model.dart';
import 'package:degreed/features/home/domain/entities/dad_joke_entity.dart';
import 'package:degreed/features/home/domain/usecase/get_dad_jokes_usecase.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetDadJokesDataUsecase getDadJokesDataUsecase;
  final GetSearchDadJokesUsecase getSearchDadJokesUsecase;

  bool isLoading = false;
  int limit = 20;
  Timer? debounce;
  PaginationScrollController paginationScrollController =
      PaginationScrollController();
  SearchDadJokeResultsEntity? searchDadJokeResultsEntity;

  TextEditingController searchController = TextEditingController();
  HomeBloc(
      {required this.getDadJokesDataUsecase,
      required this.getSearchDadJokesUsecase})
      : super(DadJokesInitialState()) {
    on<DadJokesInitialEvent>((event, emitState) {});

    on<FetchSingleDadJokeEvent>((event, emitState) async {
      var jokeEntity = await getDadJokesDataUsecase(NoParamsModel());
      jokeEntity.fold((failure) {
        emitState(FetchErrorState(apiFailureModel: failure));
      }, (data) {
        emitState(FetchSingleDadJokeState(dadJokeEntity: data));
      });
    });

    on<FetchSearchResultsEvent>((event, emitState) async {
      isLoading = true;
      emitState(LoadingState());
      if (event.isNewSearch == true) {
        searchDadJokeResultsEntity = null;
      }
      var searchDadJokeResult =
          await getSearchDadJokesUsecase(SearchDadJokeRequestModel(
        limit: event.limit,
        page: event.page,
        term: event.term,
      ));

      isLoading = false;
      SearchDadJokeResultsEntity? searchDadJokeResults;
      searchDadJokeResult.fold((failure) {
        emitState(FetchErrorState(apiFailureModel: failure));
      }, (data) {
        searchDadJokeResults = data;
        if (searchDadJokeResultsEntity == null) {
          searchDadJokeResultsEntity = searchDadJokeResults;
          emitState(HideLoadingState());
        } else {
          searchDadJokeResultsEntity!.results = [
            ...searchDadJokeResultsEntity!.results!,
            ...searchDadJokeResults!.results!,
          ];
          searchDadJokeResultsEntity!.currentPage =
              searchDadJokeResults!.currentPage;
          searchDadJokeResultsEntity!.totalPages =
              searchDadJokeResults!.totalPages;
          searchDadJokeResultsEntity!.nextPage = searchDadJokeResults!.nextPage;
        }
        emitState(FetchSearchResultsState());
      });
    });
  }
  @override
  Future<void> close() {
    paginationScrollController.dispose();
    debounce?.cancel();
    return super.close();
  }
}
