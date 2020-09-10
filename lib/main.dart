import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/AuthBloc.dart';
import 'Bloc/NavigatorBloc.dart';
import 'Bloc/SplashScreenBloc.dart';
import 'UI/halamanSplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Widget _appCache;

  @override
  Widget build(BuildContext context) {
    if (_appCache == null)
      _appCache = _buildApp();
    return _appCache;
  }

  static Widget _buildApp (){
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context){
              return AuthBloc();
            },
          ),
          BlocProvider<NavigatorBloc>(
            create: (context){
              return NavigatorBloc();
            },
          ),
          BlocProvider<SplashScreenBloc>(
            create: (context){
              return SplashScreenBloc();
            },
          ),
        ],
        child: MaterialApp(
          title: 'Employee App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: halamanSplashScreen(),
        )
    );
  }
}
