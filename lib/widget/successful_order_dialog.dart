import 'package:countdown/common/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../common/const/asset_paths.dart';

class OrderSuccessDialog extends StatelessWidget {
  const OrderSuccessDialog({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AssetPaths.completed).pb(16),
          Text(
            "Congratulations!",
            style: context.textStyles.headlineMedium
                ?.copyWith(color: context.color.primaryColor),
          ).pb(8),
          Text.rich(
            TextSpan(children: [
              const TextSpan(
                text: 'You have successfully purchased ticket for ',
              ),
              TextSpan(
                  text: '$message',
                  style: context.textStyles.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const TextSpan(text: ".\n Enjoy the event!")
            ]),
            style: context.textStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
