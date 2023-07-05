import 'package:flutter/material.dart';

class CountdownScreen extends StatelessWidget {
  const CountdownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CountdownScreen"),
      ),
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: []),
      ),
    );
  }
}
