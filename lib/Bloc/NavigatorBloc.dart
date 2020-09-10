import 'package:employeeapp/Bloc/AuthBloc.dart';
import 'package:employeeapp/Bloc/EmployeeBloc.dart';
import 'package:employeeapp/UI/halamanCreateEmployee.dart';
import 'package:employeeapp/UI/halamanDetailEmployee.dart';
import 'package:employeeapp/UI/halamanListEmployee.dart';
import 'package:employeeapp/UI/halamanLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ImagePickerBloc.dart';

abstract class NavigatorEvent{
  BuildContext context;
  var data;
}

class NavigatePop extends NavigatorEvent{
  NavigatePop(BuildContext _context){
    context = _context;
  }
}

class NavigateRemoveToListEmployee extends NavigatorEvent{
  NavigateRemoveToListEmployee(BuildContext _context){
    context = _context;
  }
}

class NavigateRemoveToLogin extends NavigatorEvent{
  NavigateRemoveToLogin(BuildContext _context){
    context = _context;
  }
}

class NavigateDetailEmployee extends NavigatorEvent{
  NavigateDetailEmployee(BuildContext _context, var _data){
    context = _context;
    data = _data;
  }
}

class NavigateCreateEmployee extends NavigatorEvent{
  NavigateCreateEmployee(BuildContext _context){
    context = _context;
  }
}

class NavigatorBloc extends Bloc<NavigatorEvent, dynamic>{
  NavigatorBloc() : super(null);

  @override
  Stream<dynamic> mapEventToState(NavigatorEvent event) async* {
    if(event is NavigatePop) Navigator.pop(event.context);
    else if(event is NavigateRemoveToLogin)
      Navigator.pushAndRemoveUntil(
          event.context,
          MaterialPageRoute(
              builder: (context) => halamanLogin()
          ),
          ModalRoute.withName("/halaman_login")
      );
    else if(event is NavigateRemoveToListEmployee) {
      Navigator.pushAndRemoveUntil(
          event.context,
          MaterialPageRoute(
            builder: (context) =>
                MultiBlocProvider(
                    providers: [
                      BlocProvider<EmployeeBloc>(
                        create: (context) {
                          return EmployeeBloc();
                        },
                      ),
                    ],
                    child: halamanListEmployee()
                ),
          ),
          ModalRoute.withName("/halaman_list_employee")
      );
    }
    else if(event is NavigateDetailEmployee)
      Navigator.push(event.context, MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<EmployeeBloc>(
                create: (context){
                  return EmployeeBloc(initialState: ParseDataEmployeeState(event.data));
                },
              ),
            ],
            child: halamanDetailEmployee()
        ),
      ),);
    else if(event is NavigateCreateEmployee)
      Navigator.push(event.context, MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<EmployeeBloc>(
                create: (context){
                  return EmployeeBloc();
                },
              ),
              BlocProvider<ImagePickerBloc>(
                create: (context){
                  return ImagePickerBloc();
                },
              ),
            ],
            child: halamanCreateEmployee()
        ),
      ),);
  }
}