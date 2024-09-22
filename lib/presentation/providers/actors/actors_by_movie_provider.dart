
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorRepository = ref.watch( actorsRepositoryProvider );
  return ActorsByMovieNotifier(getActos: actorRepository.getActorByMovie );
});

typedef GetActorsCallback = Future<List<Actor>>Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {

  final GetActorsCallback getActos;

  ActorsByMovieNotifier({
    required this.getActos
  }): super({});

  Future<void> loadActors(String movieId) async {
    if( state[movieId] != null ) return;
    final List<Actor> actors = await getActos( movieId );
    state = { ...state, movieId: actors };
  }


}