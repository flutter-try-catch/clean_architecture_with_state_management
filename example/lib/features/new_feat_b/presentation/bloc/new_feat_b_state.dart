part of 'new_feat_b_bloc.dart';
abstract class NewFeatBState {
  const NewFeatBState();
}

class NewFeatBInitial extends NewFeatBState {
  const NewFeatBInitial();
}
class NewFeatBLoading extends NewFeatBState {
  const NewFeatBLoading();
}
class NewFeatBLoaded extends NewFeatBState {
  const NewFeatBLoaded();
}
class NewFeatBError extends NewFeatBState {
  final Exception exception;
  const NewFeatBError(this.exception);
}

