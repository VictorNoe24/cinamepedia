import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntoty( Cast cast ) => 
  Actor(
    id: cast.id, 
    name: cast.name, 
    profile: cast.profilePath != null
      ? 'https://image.tmdb.org/t/p/w500${ cast.profilePath }'
      : 'https://forum-asia.org/wp-content/uploads/2023/11/no-profile-picture-icon-12.gif', 
    character: cast.character
  );
}