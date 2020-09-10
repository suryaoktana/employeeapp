import 'package:bloc/bloc.dart';
import 'package:employeeapp/Bloc/NavigatorBloc.dart';
import 'package:employeeapp/DataProvider/Employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CustomFunction.dart';

abstract class EmployeeEvent{
  BuildContext context;
  GlobalKey<FormState> formKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  ModelCreateEmployee modelCreateEmployee;
}

class GetListEmployeeEvent extends EmployeeEvent{
  GetListEmployeeEvent(BuildContext _context){
    context = _context;
  }
}

class CreateEmployeeEvent extends EmployeeEvent{
  CreateEmployeeEvent(BuildContext _context, GlobalKey<ScaffoldState> _scaffoldKey, GlobalKey<FormState> _formKey, ModelCreateEmployee _modelCreateEmployee){
    context = _context;
    scaffoldKey = _scaffoldKey;
    modelCreateEmployee = _modelCreateEmployee;
    formKey = _formKey;
  }
}

abstract class EmployeeState{
  ModelEmployee modelEmployee;
  Datum data;
}

class EmployeeProgress extends EmployeeState{
  EmployeeProgress(EmployeeEvent event){
    ProgressDialogDelayed.show(event.context);
  }
}

class GetListEmployeeSuccessState extends EmployeeState{
  GetListEmployeeSuccessState(EmployeeEvent event, ModelEmployee _data){
    ProgressDialogDelayed.hide(event.context);
    modelEmployee = _data;
  }
}

class CreateEmployeeSuccessState extends EmployeeState{
  CreateEmployeeSuccessState(EmployeeEvent event){
    ProgressDialogDelayed.hide(event.context);
    showSnackBarDelayed(event.scaffoldKey, "Data Successfully submitted");
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      BlocProvider.of<NavigatorBloc>(event.context).add(NavigateRemoveToListEmployee(event.context));
    });
  }
}

class EmployeeErrorState extends EmployeeState{
  EmployeeErrorState(EmployeeEvent event, String message){
    ProgressDialogDelayed.hide(event.context);
    showSnackBarDelayed(event.scaffoldKey, message);
  }
}

class ParseDataEmployeeState extends EmployeeState{
  ParseDataEmployeeState(Datum _data){
    data = _data;
  }
}

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState>{
  EmployeeState initialState;
  EmployeeBloc({this.initialState}) : super(initialState);

  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent event) async*{
    // TODO: implement mapEventToState
    if(event is GetListEmployeeEvent){
      EmployeeProgress(event);
      ModelEmployee data = await Employee().GetListEmployee();
      if(data!=null) yield GetListEmployeeSuccessState(event, data);
      else EmployeeErrorState(event, "an error occured during get data");
    }
    else if(event is CreateEmployeeEvent){
      if (event.formKey.currentState.validate()){
        EmployeeProgress(event);
        ModelCreateEmployee data = await Employee().CreateEmployee(event.modelCreateEmployee);
        if(data!=null) CreateEmployeeSuccessState(event);
        else EmployeeErrorState(event, "an error occured during send data");
      }
      else EmployeeErrorState(event, "please fill the blank form");
    }
  }
}