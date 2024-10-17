import 'package:degreed/core/model_to_entity_mapper/mapper.dart';
import 'package:degreed/feature/home/data/models/dad_joke_model.dart';

class DadJokeEntity extends Mapper<DadJokeModel, DadJokeEntity> {
  String? id;
  String? joke;

  DadJokeEntity({this.id, this.joke});

  @override
  DadJokeEntity call(DadJokeModel object) {
    return DadJokeEntity(
      id: object.id,
      joke: object.joke,
    );
  }
}
