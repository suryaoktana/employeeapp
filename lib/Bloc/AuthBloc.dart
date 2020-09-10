import 'package:bloc/bloc.dart';
import 'package:employeeapp/Bloc/NavigatorBloc.dart';
import 'package:employeeapp/DataProvider/sharedPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../DataProvider/Auth.dart';
import 'CustomFunction.dart';

//INBOUND EVENT
abstract class AuthEvent{
  String email;
  String password;
  BuildContext context;
  GlobalKey<ScaffoldState> scaffoldKey;
}

class LoginEvent extends AuthEvent {
  LoginEvent(_email, _password, _context, _scaffoldKey){
    email = _email;
    password = _password;
    context = _context;
    scaffoldKey = _scaffoldKey;
  }
}

class LogoutEvent extends AuthEvent {
  LogoutEvent(_context){
    context = _context;
  }
}

class GetUserDataEvent extends AuthEvent{}
//

//OUTBOUND STATE
abstract class AuthState{
  ModelLogin data;
}

class AuthProgress extends AuthState{
  AuthProgress(AuthEvent event){
    ProgressDialogDelayed.show(event.context);
  }
}

class AuthLoginSuccess extends AuthState{
  AuthLoginSuccess(AuthEvent event){
    ProgressDialogDelayed.hide(event.context);
    BlocProvider.of<NavigatorBloc>(event.context).add(NavigateRemoveToListEmployee(event.context));
  }
}

class AuthLogoutSuccess extends AuthState{
  AuthLogoutSuccess(AuthEvent event){
    BlocProvider.of<NavigatorBloc>(event.context).add(NavigateRemoveToLogin(event.context));
  }
}

class AuthError extends AuthState{
  AuthError(AuthEvent event, String message){
    ProgressDialogDelayed.hide(event.context);
    showSnackBarDelayed(event.scaffoldKey, message);
  }
}
//

class AuthBloc extends Bloc<AuthEvent, ModelLogin>{
  AuthBloc() : super(null);

  @override
  Stream<ModelLogin> mapEventToState(AuthEvent event) async*{
    // TODO: implement mapEventToState
    if(event is LoginEvent){
      AuthProgress(event);
      ModelLogin data = await Auth().Login(event);
      if(data.error==null){
        await sharedPreferences().setUserData(data);
        AuthLoginSuccess(event);
        yield data;
      }
      else AuthError(event, data.error);
    }
    else if(event is LogoutEvent){
      await sharedPreferences().remove('user');
      AuthLogoutSuccess(event);
    }
    else if(event is GetUserDataEvent){
      ModelLogin data = await sharedPreferences().getUserData();
      yield data;
    }
  }
}