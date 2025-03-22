import 'package:flutter/material.dart';

class CustomAdditionalCol extends StatelessWidget {
 const CustomAdditionalCol({
    super.key,
    required this.bodyText,
    required this.icon,
    required this.measure,
  });

  final IconData icon;
  final  String bodyText;
  final int measure;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 90,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            size: 30,
          ),
          Text(
            bodyText,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            measure.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
