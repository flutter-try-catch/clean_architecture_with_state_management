import 'package:../../domain/use_cases/new_feat_b_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/new_feat_b_use_case.dart';

part 'new_feat_b_event.dart';
part 'new_feat_b_state.dart';

class NewFeatBBloc extends Bloc<NewFeatBEvent, NewFeatBState> {
  final NewFeatBUseCase newFeatBUseCase;

  NewFeatBBloc({required this.newFeatBUseCase}) : super(NewFeatBInitial());

  @override
  Stream<NewFeatBState> mapEventToState(NewFeatBEvent event) async* {
    if (event is NewFeatBEvent) {
      yield NewFeatBLoading();
      final result = await newFeatBUseCase.call();
      yield result.fold(
        (exception) => NewFeatBError(exception),
        (_) => NewFeatBLoaded(),
      );
    }
  }
}

      