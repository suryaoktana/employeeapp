import 'package:employeeapp/Bloc/EmployeeBloc.dart';
import 'package:employeeapp/Bloc/NavigatorBloc.dart';
import 'package:employeeapp/UI/Template/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class halamanDetailEmployee extends StatelessWidget {
  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: SingleChildScrollView(
        child:
        BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (BuildContext context, EmployeeState state){
            return state is ParseDataEmployeeState!=null?Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height/2,
                      width: MediaQuery.of(context).size.width,
                      color: CustomStyle.color1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: new BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.grey[100],
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                                borderRadius: new BorderRadius.all(Radius.circular(120.0)
                                )
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(120.0),
                                child: Image.network(state.data.avatar, height: 240, width: 240, fit: BoxFit.cover,)
                            ),
                          ),
                          SizedBox(height: 16,),
                          Text(state.data.firstName+' '+state.data.lastName, style: TextStyle(fontSize: CustomStyle.fontSizeJumbo, color: Colors.white, fontWeight: FontWeight.bold),),
                          SizedBox(height: 24,),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: GestureDetector(
                        onTap: ()=> BlocProvider.of<NavigatorBloc>(_context).add(NavigatePop(_context)),
                        child: Container(
                          padding: EdgeInsets.only(left: 12),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.arrow_back, color: Colors.white, size: 28,)),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      CardDetail(state.data.email, "E-mail", Icons.email, Icons.message),
                      CardDetail(state.data.firstName, "First Name", Icons.person, null),
                      CardDetail(state.data.lastName, "Last Name", Icons.person, null),
                    ],
                  ),
                )
              ],
            ):Container();
          },
        ),
      ),
    );
  }

  Widget CardDetail(label1, label2, icon1, icon2){
    return Card(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 18, 16, 18),
        child: Row(
          children: <Widget>[
            Icon(icon1, color: CustomStyle.color1,),
            SizedBox(width: 16,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(label1, style: TextStyle(color: CustomStyle.fontColorBlack, fontSize: CustomStyle.fontSizeNormal+1),),
                Text(label2, style: TextStyle(color: CustomStyle.fontColorGrey,),),
              ],
            )),
            SizedBox(width: 16,),
            icon2!=null?Icon(icon2, color: Colors.grey,):Container()
          ],
        ),
      ),
    );
  }
}
