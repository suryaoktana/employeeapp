import 'package:employeeapp/UI/Template/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TemplateFormPassword extends StatefulWidget {
  const TemplateFormPassword(
      {this.controller,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.onFieldSubmitted,
      this.bottomMargin = 8.0,
      this.titleText,
      this.prefixIcon,
      this.color = Colors.white,
      this.radius = 16.0,
      this.formHeight = 48});
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String helperText;
  final String titleText;
  final double bottomMargin;
  final double formHeight;
  final double radius;
  final FormFieldSetter<String> onSaved;
  final ValueChanged<String> onFieldSubmitted;
  final prefixIcon;
  final color;

  @override
  _TemplateFormPasswordState createState() => _TemplateFormPasswordState();
}

class _TemplateFormPasswordState extends State<TemplateFormPassword> {
  bool _obscureText = true;
  String _validate(String value) {
    if (value.isEmpty) return 'Please fill this form.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.bottomMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.titleText != null
              ? Text(
                  widget.titleText,
                  style: Theme.of(context).textTheme.body1,
                )
              : Container(),
          Container(
            height: widget.formHeight,
            child: TextFormField(
              cursorColor: widget.color,
              controller: widget.controller,
              obscureText: _obscureText,
              onSaved: widget.onSaved,
              validator: _validate,
              onFieldSubmitted: widget.onFieldSubmitted,
              style: TextStyle(fontSize: CustomStyle.fontSizeSmall, color: widget.color),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                  borderSide: BorderSide(
                    color: widget.color,
                    width: 0.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                  borderSide: BorderSide(
                    color: widget.color,
                    width: 1,
                  ),
                ),
                hintStyle: TextStyle(color: widget.color),
                labelStyle: TextStyle(color: widget.color),
                fillColor: Colors.transparent,
                filled: true,
                prefixIcon: widget.prefixIcon,
                contentPadding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
                hintText: widget.hintText,
                labelText: widget.labelText,
                helperText: widget.helperText,
                suffixIcon: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    semanticLabel:
                        _obscureText ? 'show password' : 'hide password',
                    color: widget.color,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
