import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/new_feat_b_use_case.dart';

part 'new_feat_b_event.dart';
part 'new_feat_b_state.dart';

class NewFeatBBloc extends Bloc<NewFeatBEvent, NewFeatBState> {
  final NewFeatBUseCase newFeatBUseCase;

  NewFeatBBloc({required this.newFeatBUseCase})
      : super(const NewFeatBInitial());

  Stream<NewFeatBState> mapEventToState(NewFeatBEvent event) async* {
    yield const NewFeatBLoading();
    final result = await newFeatBUseCase.call();
    yield result.fold(
      (exception) => NewFeatBError(exception),
      (_) => const NewFeatBLoaded(),
    );
  }
}
