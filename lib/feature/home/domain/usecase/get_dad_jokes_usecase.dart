import 'package:dartz/dartz.dart';
import 'package:degreed/core/models/api_failure_model.dart';
import 'package:degreed/core/models/no_param_model.dart';
import 'package:degreed/feature/home/domain/entities/dad_joke_entity.dart';
import 'package:degreed/feature/home/domain/repository/dad_jokes_repository.dart';
import 'package:degreed/core/usecase/usecase.dart';

class GetDadJokesDataUsecase
    extends Usecase<Either<ApiFailureModel, DadJokeEntity>, NoParamsModel> {
  final DadJokesRepository dadJokesRepository;

  GetDadJokesDataUsecase(this.dadJokesRepository);
  @override
  Future<Either<ApiFailureModel, DadJokeEntity>> call(
          NoParamsModel params) async =>
      dadJokesRepository.getSingleJoke(params: params);
}
