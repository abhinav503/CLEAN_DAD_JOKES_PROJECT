part of 'home_bloc.dart';

sealed class HomeEvent {}

class DadJokesInitialEvent extends HomeEvent {}

class FetchSingleDadJokeEvent extends HomeEvent {}

class FetchSearchResultsEvent extends HomeEvent {
  final String term;
  final int? limit;
  final int? page;
  final bool? isNewSearch;

  FetchSearchResultsEvent({
    required this.term,
    this.limit = 20,
    this.page,
    this.isNewSearch = false,
  });
}
