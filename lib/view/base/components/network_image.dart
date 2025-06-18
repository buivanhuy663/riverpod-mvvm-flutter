import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'progress_indicator_platform.dart';

class ImageNetwork extends StatelessWidget {
  const ImageNetwork({
    required this.url,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
    imageUrl: url,
    width: width,
    height: height,
    // imageBuilder: (context, imageProvider) => Container(
    //   height: height,
    //   width: width,
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: imageProvider,
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    // ),
    placeholder: (context, url) => const ProgressIndicatorPlatform(),
    errorWidget: (context, url, error) => const Icon(Icons.error, size: 50, color: Colors.red),
  );
}
