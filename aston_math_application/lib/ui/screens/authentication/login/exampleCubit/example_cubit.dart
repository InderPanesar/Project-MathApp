import 'package:aston_math_application/engine/model/example/example_response.dart';
import 'package:aston_math_application/engine/repository/example_repository.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'example_state.dart';


class ExampleCubit extends Cubit<ExampleState> {
  ExampleCubit({required this.repo}) : super(ExampleState.loading()) {
    getOffers();
  }

  ExampleRepository repo;

  Future<void> getOffers() async {
    List<ExampleResponse> data = await repo.getResponse();
    if(data == null){
      emit(ExampleState.failed());
    } else if (data.isEmpty) {
      emit(ExampleState.empty());
    } else {
      emit(ExampleState.success(data));
    }
    return;
  }
}