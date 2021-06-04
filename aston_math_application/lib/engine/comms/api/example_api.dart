import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:aston_math_application/engine/model/example/example_response.dart';


part 'example_api.g.dart';

@RestApi()
abstract class ExampleApi {
  factory ExampleApi(Dio dio, {String baseUrl}) = _ExampleApi;

  @FormUrlEncoded()
  @GET("/films")
  Future<List<ExampleResponse>> getFilms();

}