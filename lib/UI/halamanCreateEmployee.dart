import 'package:employeeapp/Bloc/EmployeeBloc.dart';
import 'package:employeeapp/Bloc/ImagePickerBloc.dart';
import 'package:employeeapp/DataProvider/Employee.dart';
import 'package:employeeapp/DataProvider/PickImage.dart';
import 'package:employeeapp/UI/Template/style.dart';
import 'package:employeeapp/UI/Template/templateForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class halamanCreateEmployee extends StatelessWidget {
  TextEditingController name = new TextEditingController();
  TextEditingController job = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ModelImagePicker imageData = new ModelImagePicker(null, "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Create Employee", style: TextStyle(fontSize: CustomStyle.fontSizeHeader),),
          GestureDetector(
            onTap: ()=>BlocProvider.of<EmployeeBloc>(context).add(CreateEmployeeEvent(context, _scaffoldKey, _formKey, ModelCreateEmployee(name: name.text, job: job.text))),
            child: Text("Submit", style: TextStyle(fontSize: CustomStyle.fontSizeHeader),),
          )
        ],
      ), backgroundColor: CustomStyle.color1,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                BlocConsumer<ImagePickerBloc, ModelImagePicker>(
                  listener: (BuildContext context, ModelImagePicker data){
                    imageData = data;
                  },
                  builder: (BuildContext context, ModelImagePicker data){
                    return Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: ()=>BlocProvider.of<ImagePickerBloc>(context).add(GetImageCameraEvent()),
                        child: Container(
                          margin: EdgeInsets.only(top: 32, bottom: 18),
                          width: 162,
                          height: 162,
                          decoration: BoxDecoration(
                              color: CustomStyle.color1, borderRadius: new BorderRadius.all(Radius.circular(100))
                          ),
                          child: Center(child: data==null?Icon(Icons.camera_alt, color: Colors.white,):ClipRRect(
                              borderRadius: BorderRadius.circular(120.0),
                              child: Image.file(data.imageFile, height: 162, width: 162, fit: BoxFit.cover,)
                          ),),
                        ),
                      ),
                    );
                  },
                ),
                TemplateForm(
                  enabledBorder: false,
                  color: Colors.black,
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person, size: 22,),
                  controller: name,
                  adaValidasi: true,
                ),
                TemplateForm(
                  enabledBorder: false,
                  color: Colors.black,
                  labelText: "Job",
                  prefixIcon: Icon(Icons.work, size: 20,),
                  controller: job,
                  adaValidasi: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
