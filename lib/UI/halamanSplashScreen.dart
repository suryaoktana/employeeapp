import 'package:employeeapp/Bloc/AuthBloc.dart';
import 'package:employeeapp/Bloc/SplashScreenBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class halamanSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashScreenBloc>(context).add(InitStateEvent(context));
    BlocProvider.of<AuthBloc>(context).add(GetUserDataEvent());
    return Scaffold(
      body: Center(
        child: Text("Welcome to Employee App!"),
      ));
  }
}

