import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mended/utils/path.dart';
import 'package:shimmer/shimmer.dart';

class CustomCircleAvtar extends StatelessWidget {
  final String? url;
  final double height;
  final double width;
  const CustomCircleAvtar(
      {super.key, this.url = "", this.height = 50, this.width = 50});

  @override
  Widget build(BuildContext context) {
    return url == null
        ? Container(
            height: height,
            width: width,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  Assets.profileIcon,
                ),
              ),
            ),
          )
        : CachedNetworkImage(
            height: height,
            width: width,
            imageUrl: url ?? "",
            imageBuilder: (context, imageProvider) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade200,
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              height: height,
              width: width,
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                      Assets.profileIcon,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          );
  }
}

class CustomCachedImage extends StatelessWidget {
  final String? url;
  final double height;
  final double width;
  final String errorimage;
  final double borderRadius;
  final bool fullview;
  final dynamic onTap;
  const CustomCachedImage({
    super.key,
    this.url = "",
    this.height = 50,
    this.width = 50,
    this.errorimage = "",
    this.borderRadius = 8,
    this.fullview = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return fullview
        ? InkWell(
            onTap: onTap ??
                () {
                  if (fullview && url != "") {
                    // Go.named(context, 'full-view', {
                    //   'url': url ?? "",
                    // });
                  }
                },
            child: CachedNetworkImage(
              height: height,
              width: width,
              imageUrl: url ?? "",
              imageBuilder: (context, imageProvider) => Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade200,
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  image: const DecorationImage(
                      image: AssetImage(
                        '',
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          )
        : CachedNetworkImage(
            height: height,
            width: width,
            imageUrl: url ?? "",
            imageBuilder: (context, imageProvider) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade200,
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                image: const DecorationImage(
                    image: AssetImage(
                      '',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          );
  }
}

class CardShimer extends StatelessWidget {
  final double height;
  final double width;

  final double borderRadius;

  const CardShimer({
    super.key,
    this.height = 50,
    this.width = 50,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.grey.shade200,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}
