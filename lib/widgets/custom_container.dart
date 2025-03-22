import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.condition,
    required this.degree,
    required this.heights,
    required this.sizes,
    required this.fontSize,
    required this.conditionFontSize,
    required this.icon,
  });

  final double heights;
  final String degree;
  final String condition;
  final double sizes;
  final double fontSize;
  final double conditionFontSize;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heights,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                degree,
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
              Icon(
                icon,
                size: sizes,
              ),
              Text(
                condition,
                style: TextStyle(
                  fontSize: conditionFontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
