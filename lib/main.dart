import 'package:dio/dio.dart';
import 'package:filmku_id/app_constant.dart';
import 'package:filmku_id/movie/pages/movie_pages.dart';
import 'package:filmku_id/movie/providers/movie_get_discover_provider.dart';
import 'package:filmku_id/movie/repositories/movie_repository.dart';
import 'package:filmku_id/movie/repositories/movie_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dioOptions = BaseOptions(
    baseUrl: AppConstants.baseUrl,
    queryParameters: {'api_key': AppConstants.apikey},
  );
  final Dio dio = Dio(dioOptions);
  final MovieRepository movieRepository = MovieRepositoryimpl(dio);
  runApp(MyApp(movieRepository: movieRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.movieRepository}) : super(key: key);

  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieGetDiscoverProvider(movieRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MoviePage(),
      ),
    );
  }
}
