import 'package:flutter/material.dart';

import '../common/export.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sorry, Not Found'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetPaths.notFound404).pb(16),
          Text(
            "Sorry, the page you're looking for not found.",
            style: context.textStyles.bodyMedium,
            textAlign: TextAlign.center,
          ).ph(16),
        ],
      ),
    );
  }
}
