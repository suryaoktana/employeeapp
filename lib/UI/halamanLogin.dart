import 'package:employeeapp/Bloc/AuthBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Template/style.dart';
import 'Template/templateButton.dart';
import 'Template/templateForm.dart';
import 'Template/templateFormPassword.dart';

class halamanLogin extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                color: Colors.green,
                gradient: new LinearGradient(
                    colors: [
                      CustomStyle.color1,
                      Colors.cyan,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 8,),
                  Text("Employee App", style: TextStyle(fontWeight: FontWeight.bold, fontSize: CustomStyle.fontSizeJumbo, color: Colors.white),),
                  SizedBox(height: 60,),
                  TemplateForm(hintText: "Email", controller: email,adaValidasi: true,),
                  TemplateFormPassword(hintText: "Password", controller: password,),
                  SizedBox(height: 36,),
                  TemplateButton(
                    label: "Sign In",
                    color: Colors.white,
                    bold: true,
                    radius: 12,
                    contentColor: CustomStyle.fontColorBlack,
                    fontSize: CustomStyle.fontSizeTitle,
                    paddingTopBottom: 10, expand: true,
                    borderColor: Colors.white,
                    onClick: (){
                      BlocProvider.of<AuthBloc>(context).add(LoginEvent(email.text, password.text, context, _scaffoldKey));
                    },
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
