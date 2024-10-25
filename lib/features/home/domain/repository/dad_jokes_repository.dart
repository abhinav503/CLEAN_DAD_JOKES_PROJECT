import 'package:dartz/dartz.dart';
import 'package:degreed/core/models/api_failure_model.dart';
import 'package:degreed/core/models/no_param_model.dart';
import 'package:degreed/core/models/search_dad_joke_request_model.dart';
import 'package:degreed/features/home/domain/entities/dad_joke_entity.dart';
import 'package:degreed/features/home/domain/entities/search_dad_joke_results_entity.dart';

abstract class DadJokesRepository {
  Future<Either<ApiFailureModel, DadJokeEntity>> getSingleJoke(
      {required NoParamsModel params});
  Future<Either<ApiFailureModel, SearchDadJokeResultsEntity>>
      getJokeSearchResults({required SearchDadJokeRequestModel params});
}
