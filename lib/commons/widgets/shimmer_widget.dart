import 'package:flutter/material.dart';
import 'package:hamrokhata/commons/resources/ui_assets.dart';

class ShimmerWidget {
  static Widget rounded(
          {double? width, double? height, double? borderRadius}) =>
      _RoundedShimmer(
        borderRadius: borderRadius,
        width: width,
        height: height,
      );

  static Widget circular({double? radius}) => _CircularShimmer(
        radius: radius,
      );
}

class _CircularShimmer extends StatelessWidget {
  final double? radius;

  const _CircularShimmer({
    Key? key,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 30,
      backgroundImage:const AssetImage(UIAssets.gifLoading),
    );
  }
}

class _RoundedShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;

  const _RoundedShimmer({Key? key, this.width, this.height, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 50,
      height: height ?? 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        child: Image.asset(UIAssets.gifLoading,fit: BoxFit.cover),

      ),
    );
  }
}
