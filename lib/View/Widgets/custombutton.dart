import 'package:flutter/material.dart';

class CustomBotton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? color;

  CustomBotton({super.key, required this.text, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 48,
        height: 53,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: color == null
                  ? [Color(0xffA175EA), Color(0xff7568F2)]
                  : [color!, color!]),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              )),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.transparent;
                }
                return Colors.transparent;
              })),
          child: Text(text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white)),
        ));
  }
}
