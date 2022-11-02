// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:extended_image/extended_image.dart';

// Project imports:
import 'loading_indicator.dart';

/// サムネイル（四角）
class Thumbnail extends StatelessWidget {
  const Thumbnail({
    this.url,
    this.file,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.child,
    this.cacheMaxAge,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final String? url;
  final Uint8List? file;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;
  final Widget? child;
  final Duration? cacheMaxAge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget image() {
      Widget imageFromUrl(ImageProvider imageProvider) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider,
            ),
          ),
          child: child,
        );
      }

      Widget imageFromFile(Uint8List file) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              fit: fit,
              image: Image.memory(
                file,
                fit: BoxFit.fitWidth,
              ).image,
            ),
          ),
          child: child,
        );
      }

      Widget noImageWidget() {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: const Color(0xFFDADADA),
          ),
          child: Center(
            child: Icon(
              Icons.insert_photo,
              color: Colors.white,
              size: width != null ? width! * 0.5 : 32,
            ),
          ),
        );
      }

      if (file != null) {
        return imageFromFile(file!);
      } else if (url != null) {
        return ExtendedImage.network(
          url!,
          width: width,
          height: height,
          fit: BoxFit.cover,
          cache: true,
          cacheMaxAge: cacheMaxAge ?? const Duration(days: 90),
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return const CircleLoadingIndicator();
              case LoadState.completed:
                return imageFromUrl(state.imageWidget.image);
              case LoadState.failed:
                return noImageWidget();
            }
          },
        );
      }
      return noImageWidget();
    }

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: image(),
      ),
    );
  }
}

/// サムネイル（円）
class CircleThumbnail extends StatelessWidget {
  const CircleThumbnail({
    this.size = 60,
    this.url,
    this.file,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.noImageIconData,
    this.isLoading = false,
    this.loadingWidget,
    this.cacheMaxAge,
    this.onTap,
    Key? key,
  }) : super(key: key);
  final double size;

  final String? url;
  final Uint8List? file;
  final BoxFit fit;
  final Color? backgroundColor;
  final IconData? noImageIconData;
  final bool isLoading;
  final Widget? loadingWidget;
  final Duration? cacheMaxAge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget image() {
      Widget noImageWidget() {
        return SizedBox(
          width: size,
          height: size,
          child: ColoredBox(
            color: backgroundColor ?? Colors.grey[400]!,
            child: Icon(
              noImageIconData ?? Icons.person,
              color: Colors.white,
              size: size * 0.8,
            ),
          ),
        );
      }

      if (file != null) {
        return Image.memory(
          file!,
          height: size,
          width: size,
          fit: fit,
        );
      }

      if (url != null) {
        return ExtendedImage.network(
          url!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          cache: true,
          cacheMaxAge: cacheMaxAge ?? const Duration(days: 90),
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return const CircleLoadingIndicator();
              case LoadState.completed:
                return Image(
                  image: state.imageProvider,
                  height: size,
                  width: size,
                  fit: fit,
                );
              case LoadState.failed:
                return noImageWidget();
            }
          },
        );
      }
      return noImageWidget();
    }

    return ClipOval(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: isLoading != true ? onTap : null,
          child: isLoading == true
              ? loadingWidget ?? const CircleLoadingIndicator()
              : image(),
        ),
      ),
    );
  }
}
