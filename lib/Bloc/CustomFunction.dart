import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ProgressDialogDelayed{
  ProgressDialogDelayed.show(context){
    ProgressDialog(context).show();
  }
  ProgressDialogDelayed.hide(context){
    Future.delayed(Duration(milliseconds: 500)).then((value)=>ProgressDialog(context).hide());
  }
}

class showSnackBarDelayed{
  showSnackBarDelayed(key, message){
    Future.delayed(Duration(milliseconds: 500)).then((value)=>key.currentState.showSnackBar(SnackBar(content: Text(message))));
  }
}

