import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/user_bloc.dart';

class UserScreen extends StatefulWidget {
  static const routeName = "/user";
  const UserScreen({super.key});
  @override
  State<UserScreen> createState() => _UserState();
}

class _UserState extends State<UserScreen> {
  late UserBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<UserBloc>();
    _bloc.add(UserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(UserState state) {
    if (state is UserLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is UserLoaded) {
      return Placeholder(); // Replace with your actual widget
    } else if (state is UserError) {
      return Center(
        child: Text('Error: '),
      );
    } else {
      return Container();
    }
  }
}
      