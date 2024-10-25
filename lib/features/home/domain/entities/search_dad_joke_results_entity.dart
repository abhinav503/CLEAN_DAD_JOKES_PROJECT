import 'package:degreed/core/model_to_entity_mapper/mapper.dart';
import 'package:degreed/features/home/data/models/search_dad_joke_response_model.dart';
import 'package:degreed/features/home/domain/entities/dad_joke_entity.dart';

class SearchDadJokeResultsEntity
    extends Mapper<SearchDadJokeReponseModel, SearchDadJokeResultsEntity> {
  int? currentPage;
  int? limit;
  int? nextPage;
  int? previousPage;
  List<DadJokeEntity>? results;
  String? searchTerm;
  int? totalJokes;
  int? totalPages;

  SearchDadJokeResultsEntity(
      {this.currentPage,
      this.limit,
      this.nextPage,
      this.previousPage,
      this.results,
      this.searchTerm,
      this.totalJokes,
      this.totalPages});

  @override
  SearchDadJokeResultsEntity call(SearchDadJokeReponseModel object) {
    List<DadJokeEntity> allJokes = [];
    DadJokeEntity dadJokeEntity = DadJokeEntity();
    object.results?.forEach((joke) {
      allJokes.add(dadJokeEntity(joke));
    });
    return SearchDadJokeResultsEntity(
      currentPage: object.currentPage,
      limit: object.limit,
      nextPage: object.nextPage,
      previousPage: object.previousPage,
      results: allJokes,
      searchTerm: object.searchTerm,
      totalJokes: object.totalJokes,
      totalPages: object.totalPages,
    );
  }
}
