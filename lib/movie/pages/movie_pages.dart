import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmku_id/movie/models/movie_model.dart';
import 'package:filmku_id/movie/providers/movie_get_discover_provider.dart';
import 'package:filmku_id/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            'Movie DB',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white60,
          foregroundColor: Colors.black,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Discover Movie',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                  ),
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      shape: StadiumBorder(),
                      side: BorderSide(
                        color: Colors.black54,
                      )),
                )
              ],
            ),
          ),
        ),
        WidgetDiscoverMovie(),
      ],
    ));
  }
}

class WidgetDiscoverMovie extends StatefulWidget {
  const WidgetDiscoverMovie({super.key});

  @override
  State<WidgetDiscoverMovie> createState() => _WidgetDiscoverMovieState();
}

class _WidgetDiscoverMovieState extends State<WidgetDiscoverMovie> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
                itemCount: provider.movies.length,
                itemBuilder: (_, index, __) {
                  final movie = provider.movies[index];
                  return ItemMovie(movie);
                },
                options: CarouselOptions(
                  height: 300.0,
                  viewportFraction: 0.8,
                  reverse: false,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ));
          }

          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            height: 300.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Not Found Discover Movies',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemMovie extends Container {
  final MovieModel movie;

  ItemMovie(this.movie, {super.key});

  @override
  // TODO: implement clipBehavior
  Clip get clipBehavior => Clip.hardEdge;

  @override
  // TODO: implement decoration
  Decoration? get decoration =>
      BoxDecoration(borderRadius: BorderRadius.circular(12));
  @override
  // TODO: implement child
  Widget? get child => Stack(
        children: [
          ImageNetworkWidget(
            imageSrc: '${movie.backdropPath}',
            height: 300,
            width: double.infinity,
          ),
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageNetworkWidget(
                  imageSrc: '${movie.posterPath}',
                  height: 180,
                  width: 100,
                  radius: 12,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(movie.title,
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                    // style: TextStyle(
                    //   fontSize: 18.0,
                    //   color: Colors.white,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                    Text(
                      '${movie.voteAverage} (${movie.voteCount})',
                      style: GoogleFonts.poppins(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
}
