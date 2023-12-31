import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String myLabelText;
  final VoidCallback onPressed;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.myLabelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 1.0, color: Colors.white),
        ),
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            width: MediaQuery.of(context).size.width - 100,
            child: Text(myLabelText, textAlign: TextAlign.center)));
  }
}
