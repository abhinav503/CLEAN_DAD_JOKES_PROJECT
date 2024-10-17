import 'dart:convert';

import 'package:degreed/core/constants/string_constants.dart';
import 'package:degreed/feature/home/data/models/dad_joke_model.dart';
import 'package:degreed/core/models/no_param_model.dart';
import 'package:degreed/core/network_repository/network_repository.dart';
import 'package:degreed/feature/home/data/data_source/jokes_data_source_repository.dart';
import 'package:degreed/core/models/search_dad_joke_request_model.dart';
import 'package:degreed/feature/home/data/models/search_dad_joke_response_model.dart';
import 'package:http/http.dart';

class DadJokesDataSourceRepositoryImpl extends DadJokesDataSourceRepository {
  final NetworkRepository networkRepository;

  DadJokesDataSourceRepositoryImpl({required this.networkRepository});

  @override
  Future<DadJokeModel> getSingleJoke({required NoParamsModel params}) async {
    Response response = await networkRepository.getRequest(urlSuffix: "");
    return DadJokeModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<SearchDadJokeReponseModel> getJokeSearchResults(
      {required SearchDadJokeRequestModel params}) async {
    Response response = await networkRepository.getRequest(
        urlSuffix: search.toLowerCase(), queries: params.toJson());
    return SearchDadJokeReponseModel.fromJson(jsonDecode(response.body));
  }
}
