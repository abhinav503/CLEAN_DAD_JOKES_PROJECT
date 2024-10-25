part of 'home_bloc.dart';

sealed class HomeState {}

class DadJokesInitialState extends HomeState {}

class FetchSingleDadJokeState extends HomeState {
  DadJokeEntity? dadJokeEntity;
  FetchSingleDadJokeState({required this.dadJokeEntity});
}

class FetchSearchResultsState extends HomeState {}

class LoadingState extends HomeState {}

class FetchErrorState extends HomeState {
  final ApiFailureModel apiFailureModel;

  FetchErrorState({required this.apiFailureModel});
}

class HideLoadingState extends HomeState {}
