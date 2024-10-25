import 'package:degreed/features/home/data/models/dad_joke_model.dart';
import 'package:degreed/core/models/no_param_model.dart';
import 'package:degreed/core/models/search_dad_joke_request_model.dart';
import 'package:degreed/features/home/data/models/search_dad_joke_response_model.dart';

abstract class DadJokesDataSourceRepository {
  Future<DadJokeModel> getSingleJoke({required NoParamsModel params});
  Future<SearchDadJokeReponseModel> getJokeSearchResults(
      {required SearchDadJokeRequestModel params});
}
