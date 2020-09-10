import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:employeeapp/DataProvider/Auth.dart';
import 'package:employeeapp/DataProvider/sharedPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'NavigatorBloc.dart';

abstract class SplashScreenEvent{
  BuildContext context;
}

class InitStateEvent extends SplashScreenEvent{
  InitStateEvent(BuildContext _context){
    context = _context;
  }
}

class SplashScreenBloc extends Bloc<SplashScreenEvent, String>{
  SplashScreenBloc() : super(null);

  @override
  Stream<String> mapEventToState(SplashScreenEvent event)  async*{
    // TODO: implement mapEventToState
    if(event is InitStateEvent){
      ModelLogin data = await sharedPreferences().getUserData();
      Timer(Duration(seconds: 3), (){
        if(data!=null) BlocProvider.of<NavigatorBloc>(event.context).add(NavigateRemoveToListEmployee(event.context));
        else BlocProvider.of<NavigatorBloc>(event.context).add(NavigateRemoveToLogin(event.context));
      });
    }
  }
}