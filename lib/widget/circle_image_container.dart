import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/common/export.dart';

class CircleImageContainer extends StatelessWidget {
  const CircleImageContainer({
    super.key,
    required this.imgUrl,
    this.radius,
    this.errorWidget,
    this.placeholder,
  });

  final String? imgUrl;
  final double? radius;
  final Widget? errorWidget;
  final Widget? placeholder;
  @override
  Widget build(BuildContext context) {
    print(imgUrl);
    return CachedNetworkImage(
      imageUrl: imgUrl ?? "",
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius ?? 12.fw,
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) =>
          placeholder ?? const CircularProgressIndicator(),
      errorWidget: (context, url, error) =>
          errorWidget ??
          CircleAvatar(
            radius: radius ?? 12.fw,
            backgroundImage: const AssetImage(AssetPaths.avatar),
          ),
    );
  }
}
