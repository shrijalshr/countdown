import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../common/export.dart';

class CachedImageContainer extends StatelessWidget {
  const CachedImageContainer({
    super.key,
    required this.imgUrl,
    this.fit,
    this.borderRadius,
    this.errorWidget,
    this.placeholder,
  });

  final String? imgUrl;
  final BoxFit? fit;
  final double? borderRadius;
  final Widget? errorWidget;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl ?? "",
      fit: fit ?? BoxFit.cover,
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 30),
        child: Container(
          decoration: BoxDecoration(
            image:
                DecorationImage(image: imageProvider, fit: fit ?? BoxFit.cover),
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
          height: 30,
          width: 30,
          child: placeholder ?? const CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          errorWidget ??
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage(AssetPaths.errorImage)),
                borderRadius: BorderRadius.circular(borderRadius ?? 30),
              ),
            ),
          ),
    );
  }
}
