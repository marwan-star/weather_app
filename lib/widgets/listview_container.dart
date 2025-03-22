import 'package:flutter/material.dart';

class HourlyForecastItems extends StatelessWidget {
  const HourlyForecastItems({
    super.key,
    required this.condition,
    required this.time,
    required this.icon,
  });

  final String time;
  final String condition;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      margin: const EdgeInsets.only(
        right: 10,
        top: 15,
        bottom: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 1,
            blurRadius: 11,
            offset: const Offset(4, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 1,
            blurRadius: 11,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            time.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
           Icon(
            icon,
            size: 35,
          ),
          Text(
            condition,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
