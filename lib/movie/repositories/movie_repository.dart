import 'package:filmku_id/movie/models/movie_model.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<String, MovieResponseResponse>> getDiscover({int page = 1});
}
