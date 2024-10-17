import 'package:dartz/dartz.dart';
import 'package:degreed/core/base/base_exception_model.dart';
import 'package:degreed/core/models/api_failure_model.dart';
import 'package:degreed/feature/home/data/models/dad_joke_model.dart';
import 'package:degreed/core/models/no_param_model.dart';
import 'package:degreed/feature/home/data/data_source/jokes_data_source_repository.dart';
import 'package:degreed/core/models/search_dad_joke_request_model.dart';
import 'package:degreed/feature/home/data/models/search_dad_joke_response_model.dart';
import 'package:degreed/feature/home/domain/entities/dad_joke_entity.dart';
import 'package:degreed/feature/home/domain/entities/search_dad_joke_results_entity.dart';
import 'package:degreed/feature/home/domain/repository/dad_jokes_repository.dart';

class DadJokesRepositoryImpl implements DadJokesRepository {
  final DadJokesDataSourceRepository dadJokesDataSourceRepository;

  DadJokesRepositoryImpl({required this.dadJokesDataSourceRepository});

  @override
  Future<Either<ApiFailureModel, DadJokeEntity>> getSingleJoke(
          {required NoParamsModel params}) =>
      baseMethodExceptions(() => getSingleJokeApi(params: params));

  @override
  Future<Either<ApiFailureModel, SearchDadJokeResultsEntity>>
      getJokeSearchResults({required SearchDadJokeRequestModel params}) =>
          baseMethodExceptions(() => getJokeSearchResultsApi(params: params));

  Future<Either<ApiFailureModel, DadJokeEntity>> getSingleJokeApi(
      {required NoParamsModel params}) async {
    DadJokeEntity dadJokeEntity = DadJokeEntity();
    DadJokeModel dadJokeModel =
        await dadJokesDataSourceRepository.getSingleJoke(params: params);
    return Right(dadJokeEntity(dadJokeModel));
  }

  Future<Either<ApiFailureModel, SearchDadJokeResultsEntity>>
      getJokeSearchResultsApi(
          {required SearchDadJokeRequestModel params}) async {
    SearchDadJokeResultsEntity searchDadJokeResultsEntity =
        SearchDadJokeResultsEntity();
    SearchDadJokeReponseModel searchDadJokeReponseModel =
        await dadJokesDataSourceRepository.getJokeSearchResults(params: params);
    return Right(searchDadJokeResultsEntity(searchDadJokeReponseModel));
  }
}
