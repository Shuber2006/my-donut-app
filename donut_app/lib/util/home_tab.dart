import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(
        Icons.home,
        color: Colors.grey[800],
        size: 24,
      ),
    );
  }
}



