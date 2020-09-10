
import 'package:flutter/material.dart';

class TemplateForm extends StatefulWidget {
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final String titleText;
  var color;
  var initialValue;
  final double fontSize;
  final double formHeight;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final bool enabled;
  final bool adaValidasi;
  final bool keyboardNumber;
  final bool enabledBorder;
  final double bottomMargin;
  final double topMargin;
  final double radius;
  final int maxLine;
  var prefixIcon;

  TemplateForm(
      {this.fieldKey,
      this.hintText,
      this.helperText,
      this.labelText,
      this.onSaved,
      this.validator,
      this.controller,
      this.enabled,
      this.adaValidasi = false,
      this.keyboardNumber = false,
      this.titleText,
      this.textCapitalization = TextCapitalization.words,
      this.bottomMargin = 8.0,
        this.topMargin = 8.0,
      this.maxLine = 1,
        this.initialValue,
      this.prefixIcon,
      this.color = Colors.white,
      this.fontSize = 14,
      this.radius = 16,
      this.formHeight = 48,
      this.enabledBorder = true});
  @override
  _TemplateFormState createState() => _TemplateFormState();
}

class _TemplateFormState extends State<TemplateForm> {
  String _validate(String value) {
    if (value.isEmpty) return 'Please fill this form.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: widget.topMargin, bottom: widget.bottomMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.titleText != null
              ? Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                    widget.titleText,
                    style: TextStyle(color: widget.color, fontWeight: FontWeight.bold, fontSize: widget.fontSize),
                  ),
              )
              : Container(),
          Container(
            height: widget.formHeight,
            child: TextFormField(
              initialValue: widget.initialValue,
              cursorColor: widget.color,
              maxLines: widget.maxLine,
              controller: widget.controller,
              keyboardType: widget.keyboardNumber
                  ? TextInputType.number
                  : TextInputType.text,
              key: widget.fieldKey,
              enabled: widget.enabled,
              style: TextStyle(fontSize: widget.fontSize, color: widget.color),
              decoration: InputDecoration(
                  enabledBorder: widget.enabledBorder?OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(
                      color: widget.color,
                      width: 0.8,
                    ),
                  ):null,
                  focusedBorder: widget.enabledBorder?OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(
                      color: widget.color,
                      width: 1,
                    ),
                  ):null,
                  hintStyle: TextStyle(color: widget.color),
                  labelStyle: TextStyle(color: widget.color),
                  fillColor: Colors.transparent,
                  filled: true,
                  prefixIcon: widget.prefixIcon,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  hintText: widget.hintText,
                  labelText: widget.labelText),
              validator: widget.adaValidasi == true ? _validate : null,
              onSaved: widget.onSaved,
            ),
          ),
        ],
      ),
    );
  }
}
