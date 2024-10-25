import 'package:dartz/dartz.dart';
import 'package:degreed/core/models/api_failure_model.dart';
import 'package:degreed/core/models/search_dad_joke_request_model.dart';
import 'package:degreed/features/home/domain/entities/search_dad_joke_results_entity.dart';
import 'package:degreed/features/home/domain/repository/dad_jokes_repository.dart';
import 'package:degreed/core/usecase/usecase.dart';

class GetSearchDadJokesUsecase extends Usecase<
    Either<ApiFailureModel, SearchDadJokeResultsEntity>,
    SearchDadJokeRequestModel> {
  final DadJokesRepository dadJokesRepository;

  GetSearchDadJokesUsecase(this.dadJokesRepository);
  @override
  Future<Either<ApiFailureModel, SearchDadJokeResultsEntity>> call(
          SearchDadJokeRequestModel params) =>
      dadJokesRepository.getJokeSearchResults(params: params);
}
