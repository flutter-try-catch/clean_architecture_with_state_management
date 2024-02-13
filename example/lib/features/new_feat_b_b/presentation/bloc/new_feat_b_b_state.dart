part of 'new_feat_b_b_bloc.dart';
abstract class NewFeatBBState {
  const NewFeatBBState();
}

class NewFeatBBInitial extends NewFeatBBState {
  const NewFeatBBInitial();
}
class NewFeatBBLoading extends NewFeatBBState {
  const NewFeatBBLoading();
}
class NewFeatBBLoaded extends NewFeatBBState {
  const NewFeatBBLoaded();
}
class NewFeatBBError extends NewFeatBBState {
  final Exception exception;
  const NewFeatBBError(this.exception);
}

