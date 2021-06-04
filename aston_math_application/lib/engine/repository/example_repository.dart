import 'package:aston_math_application/engine/comms/api/example_api.dart';
import 'package:aston_math_application/engine/model/example/example_response.dart';

abstract class ExampleRepository {
  Future<List<ExampleResponse>> getResponse();
}

class ExampleRepositoryImpl implements ExampleRepository {

  final ExampleApi _exampleApi;

  ExampleRepositoryImpl(this._exampleApi);

  @override
  Future<List<ExampleResponse>> getResponse() {
    return _exampleApi.getFilms();
  }



}
