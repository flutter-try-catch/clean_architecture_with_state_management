import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/new_feat_b_b_bloc.dart';

class NewFeatBBScreen extends StatefulWidget {
  const NewFeatBBScreen({super.key});
  @override
  State<NewFeatBBScreen> createState() => _NewFeatBBState();
}

class _NewFeatBBState extends State<NewFeatBBScreen> {
  late NewFeatBBBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<NewFeatBBBloc>();
    _bloc.add(NewFeatBBEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<NewFeatBBBloc, NewFeatBBState>(
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(NewFeatBBState state) {
    if (state is NewFeatBBLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is NewFeatBBLoaded) {
      return Placeholder(); // Replace with your actual widget
    } else if (state is NewFeatBBError) {
      return Center(
        child: Text('Error: '),
      );
    } else {
      return Container();
    }
  }
}
      