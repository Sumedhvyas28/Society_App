import 'package:flutter/material.dart';

class InputSection extends StatelessWidget {
  final String title;
  final String hintText;

  const InputSection({
    Key? key,
    required this.title,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
