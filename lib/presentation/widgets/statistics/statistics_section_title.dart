import 'package:flutter/material.dart';

class StatisticsSectionTitle extends StatelessWidget {
  final String title;

  const StatisticsSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
