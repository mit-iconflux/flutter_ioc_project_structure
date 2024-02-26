import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    required this.imageUrl,
    this.fit,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);
  final String imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      height: height,
      width: width,
      placeholder: (BuildContext context, String url) {
        return const Align(
          child: CircularProgressIndicator(),
        );
      },
      errorWidget: (BuildContext context, String url, dynamic error) {
        return Container(
          padding: const EdgeInsets.all(Spacings.large / 2),
          alignment: Alignment.center,
          child: const Icon(
            Icons.phone_android,
            size: 45,
          ),
        );
      },
    );
  }
}
