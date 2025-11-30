import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;
  const ErrorMessage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, size: 40, color: Colors.redAccent),
        SizedBox(height: 20),
        Text(
          errorMessage,
          style: themeData.textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
