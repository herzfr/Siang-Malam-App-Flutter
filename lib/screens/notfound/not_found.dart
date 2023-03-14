import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';

/* Created By Dwi Sutrisno */

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Coming Soon...',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: mtGrey700,
          ),
        ),
      ),
    );
  }
}
