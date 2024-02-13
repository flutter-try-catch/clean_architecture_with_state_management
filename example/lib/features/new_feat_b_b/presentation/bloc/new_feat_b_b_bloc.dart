import '../../domain/use_cases/new_feat_b_b_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_feat_b_b_event.dart';
part 'new_feat_b_b_state.dart';

class NewFeatBBBloc extends Bloc<NewFeatBBEvent, NewFeatBBState> {
  final NewFeatBBUseCase newFeatBBUseCase;

  NewFeatBBBloc({required this.newFeatBBUseCase}) : super(NewFeatBBInitial());

  @override
  Stream<NewFeatBBState> mapEventToState(NewFeatBBEvent event) async* {
    if (event is NewFeatBBEvent) {
      yield NewFeatBBLoading();
      final result = await newFeatBBUseCase.call();
      yield result.fold(
        (exception) => NewFeatBBError(exception),
        (_) => NewFeatBBLoaded(),
      );
    }
  }
}

      