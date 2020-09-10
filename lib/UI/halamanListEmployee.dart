import 'package:employeeapp/Bloc/AuthBloc.dart';
import 'package:employeeapp/Bloc/EmployeeBloc.dart';
import 'package:employeeapp/Bloc/NavigatorBloc.dart';
import 'package:employeeapp/DataProvider/Employee.dart';
import 'package:employeeapp/UI/Template/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class halamanListEmployee extends StatefulWidget {
  @override
  _halamanListEmployeeState createState() => _halamanListEmployeeState();
}

class _halamanListEmployeeState extends State<halamanListEmployee> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey = new GlobalKey<RefreshIndicatorState>();
  BuildContext _context;

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshKey.currentState.show());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: CustomStyle.color1,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Employee List", style: TextStyle(fontSize: CustomStyle.fontSizeHeader),),
                Icon(Icons.search)
              ],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<EmployeeBloc>(context).add(GetListEmployeeEvent(context));
            },
          key: _refreshKey,
            child: BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (BuildContext context, EmployeeState state){
                return state is GetListEmployeeSuccessState?ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: state.modelEmployee.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return cardEmployee(state.modelEmployee.data[index]);
                  },
                ):Container();
              },
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: ()=> BlocProvider.of<AuthBloc>(_context).add(LogoutEvent(_context)),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.grey, borderRadius: new BorderRadius.all(Radius.circular(100))
                  ),
                  child: Center(child: Icon(Icons.power_settings_new, color: Colors.white,)),
                ),
              ),
              SizedBox(width: 12,),
              GestureDetector(
                onTap: ()=> BlocProvider.of<NavigatorBloc>(_context).add(NavigateCreateEmployee(_context)),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: CustomStyle.color1, borderRadius: new BorderRadius.all(Radius.circular(100))
                  ),
                  child: Center(child: Icon(Icons.add, color: Colors.white,)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  /*Widget CardEmployee(Datum data){
    bool favorite = false;
    return GestureDetector(
      onTap: ()=> BlocProvider.of<NavigatorBloc>(_context).add(NavigateDetailEmployee(_context, data)),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  color: CustomStyle.color1, borderRadius: new BorderRadius.all(Radius.circular(100))
              ),
              child: Center(child: Text(data.firstName[0], style: TextStyle(color: Colors.white, fontSize: CustomStyle.fontSizeSubTitle),)),
            ),
            SizedBox(width: 16,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(data.firstName+' '+data.lastName, style: TextStyle(color: CustomStyle.fontColorBlack, fontSize: CustomStyle.fontSizeNormal+1),),
                SizedBox(height: 2,),
                Text(data.email, style: TextStyle(color: CustomStyle.fontColorGrey, fontSize: CustomStyle.fontSizeNormal-1),),
              ],
            )),
            SizedBox(width: 16,),
            favorite?GestureDetector(
                onTap: (){setState(() {
                  favorite = false;
                });},
                child: Icon(Icons.star, color: CustomStyle.color1,)):GestureDetector(
                onTap: (){setState(() {
                  favorite = true;
                });},
                child: Icon(Icons.star_border, color: Colors.grey,))
          ],
        ),
      ),
    );
  }*/
}

class cardEmployee extends StatefulWidget {
  Datum data;
  bool favorite = false;
  cardEmployee(this.data);
  @override
  _cardEmployeeState createState() => _cardEmployeeState();
}

class _cardEmployeeState extends State<cardEmployee> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> BlocProvider.of<NavigatorBloc>(context).add(NavigateDetailEmployee(context, widget.data)),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  color: CustomStyle.color1, borderRadius: new BorderRadius.all(Radius.circular(100))
              ),
              child: Center(child: Text(widget.data.firstName[0], style: TextStyle(color: Colors.white, fontSize: CustomStyle.fontSizeSubTitle),)),
            ),
            SizedBox(width: 16,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.data.firstName+' '+widget.data.lastName, style: TextStyle(color: CustomStyle.fontColorBlack, fontSize: CustomStyle.fontSizeNormal+1),),
                SizedBox(height: 2,),
                Text(widget.data.email, style: TextStyle(color: CustomStyle.fontColorGrey, fontSize: CustomStyle.fontSizeNormal-1),),
              ],
            )),
            SizedBox(width: 16,),
            widget.favorite?GestureDetector(
                onTap: (){setState(() {
                  widget.favorite = false;
                });},
                child: Icon(Icons.star, color: CustomStyle.color1,)):GestureDetector(
                onTap: (){setState(() {
                  widget.favorite = true;
                });},
                child: Icon(Icons.star_border, color: Colors.grey,))
          ],
        ),
      ),
    );
  }
}

