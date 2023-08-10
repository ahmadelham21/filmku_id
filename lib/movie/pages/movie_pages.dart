import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmku_id/movie/providers/movie_get_discover_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_constant.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MovieGetDiscoverProvider>().getDiscover(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(),
        WidgetDiscoverMovie(),
      ],
    ));
  }
}

class WidgetDiscoverMovie extends SliverToBoxAdapter {
  @override
  // TODO: implement child
  Widget? get child => Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Container(
              child: Text(
                'Loading',
              ),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
                itemCount: provider.movies.length,
                itemBuilder: (_, index, __) {
                  final movie = provider.movies[index];
                  // print('${AppConstants.imageUrlW500}${movie.backdropPath}');
                  return Image.network(
                      '${AppConstants.imageUrlW500}${movie.backdropPath}');
                },
                options: CarouselOptions(
                  viewportFraction: 0.8,
                  reverse: false,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ));
          }

          return Container(
            child: const Text('not found discover'),
          );
        },
      );
}
