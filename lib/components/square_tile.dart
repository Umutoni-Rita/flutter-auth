// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(18),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        height: 40,
        width: 40,
      ),
    );
  }
}
