import 'package:flutter/material.dart';


class NumberedPlate extends StatelessWidget {
  final int number;

  const NumberedPlate({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
            'assets/images/plate.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity
        ),
        Text(
          '$number',
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
