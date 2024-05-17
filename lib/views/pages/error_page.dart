import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: null,
        body: Center(child: Text('Ops! Sorry! Something went wrong!')),
      ),
    );
  }
}
