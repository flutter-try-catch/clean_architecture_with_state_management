import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/new_feat_b_bloc.dart';

class NewFeatBScreen extends StatefulWidget {
  const NewFeatBScreen({super.key});
  @override
  State<NewFeatBScreen> createState() => _NewFeatBState();
}

class _NewFeatBState extends State<NewFeatBScreen> {
  late NewFeatBBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<NewFeatBBloc>();
    _bloc.add(NewFeatBEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<NewFeatBBloc, NewFeatBState>(
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(NewFeatBState state) {
    if (state is NewFeatBLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is NewFeatBLoaded) {
      return Placeholder(); // Replace with your actual widget
    } else if (state is NewFeatBError) {
      return Center(
        child: Text('Error: '),
      );
    } else {
      return Container();
    }
  }
}
      