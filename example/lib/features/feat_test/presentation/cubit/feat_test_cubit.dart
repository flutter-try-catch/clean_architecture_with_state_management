import '../../domain/use_cases/feat_test_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feat_test_state.dart';

class FeatTestCubit extends Cubit<FeatTestState> {
  final FeatTestUseCase featTestUseCase;

  FeatTestCubit({required this.featTestUseCase}) : super(FeatTestInitial());

  Future<void> fetchData() async {
    emit(const FeatTestLoading());
    final result = await featTestUseCase.call();
    result.fold(
      (exception) => emit(FeatTestError(exception)),
      (_) => emit(const FeatTestLoaded()),
    );
  }
}

      