import 'package:dartz/dartz.dart';
import 'package:filmku_id/movie/models/movie_model.dart';
import 'package:filmku_id/movie/repositories/movie_repository.dart';
import 'package:dio/dio.dart';

class MovieRepositoryimpl implements MovieRepository {
  final Dio _dio;

  MovieRepositoryimpl(this._dio);

  @override
  Future<Either<String, MovieResponseResponse>> getDiscover({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseResponse.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get Discover movies');
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get discover movie');
    }
  }
}
