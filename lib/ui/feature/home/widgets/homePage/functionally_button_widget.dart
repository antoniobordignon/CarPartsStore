import 'package:flutter/material.dart';

class FunctionallyButtonWidget extends StatelessWidget {
  final Function() onTap;
  final String text;
  const FunctionallyButtonWidget({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.05,
          left: screenWidth * 0.02,
        ),
        child: SizedBox(
          width: screenWidth * 0.3,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: screenWidth * 0.02,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
