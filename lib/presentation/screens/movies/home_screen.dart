import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNatigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget{
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {    
    super.initState();
    ref.read( nowPlayingMoviesProvider.notifier ).laodNextPage();
    ref.read( popularMoviesProvider.notifier ).laodNextPage();
    ref.read( upComingMoviesProvider.notifier ).laodNextPage();
    ref.read( topRatedMoviesProvider.notifier ).laodNextPage();
  }
  
  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch( initialLoadingProvider );

    if (initialLoading ) return const FullSceenLoader();

    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final popularMovies = ref.watch( popularMoviesProvider );
    final upComingMovies = ref.watch( upComingMoviesProvider );
    final topRatedMovies = ref.watch( topRatedMoviesProvider );
    final moviesSlideshow = ref.watch( moviesSlideshowProvider );

    return CustomScrollView(
      slivers: [
        
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  // const CustomAppBar(),
                  MoviesSlidershow(movies: moviesSlideshow),
              
                  MovieHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subTitle: 'Lunes 19',
                    loadNextPage: ()=> ref.read(nowPlayingMoviesProvider.notifier).laodNextPage(),
                  ),
              
                  MovieHorizontalListView(
                    movies: upComingMovies,
                    title: 'Próximamente',
                    subTitle: 'En este mes',
                    loadNextPage: ()=> ref.read(upComingMoviesProvider.notifier).laodNextPage(),
                  ),
              
                  MovieHorizontalListView(
                    movies: popularMovies,
                    title: 'Populares',
                    // subTitle: 'En este mes',
                    loadNextPage: ()=> ref.read(popularMoviesProvider.notifier).laodNextPage(),
                  ),
              
                  MovieHorizontalListView(
                    movies: topRatedMovies,
                    title: 'Mejor calificadas',
                    subTitle: 'Desde siempre',
                    loadNextPage: ()=> ref.read(topRatedMoviesProvider.notifier).laodNextPage(),
                  ),

                  const SizedBox( height: 10,)
                ],
              );
            },
            childCount: 1
          ),
        )
      ]
    );
  }
}