import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final VoidCallback onClick;
  final String text;

  const CustomButtom({Key? key, required this.onClick, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 200.0,
        child: ElevatedButton(
          onPressed: onClick,
          child: Text(
            text,
            style: TextStyle(fontSize: 16.0),
          ),
        ));
  }
}
