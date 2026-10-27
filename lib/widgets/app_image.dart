import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../services/image_service.dart';

/// Shows an image stored in Firestore (data URL), a network URL, or a
/// bundled asset path.
/// Falls back to [fallbackAsset] (if given) and then [errorBuilder].
class AppImage extends StatelessWidget {
  final String source;
  final String? fallbackAsset;
  final BoxFit fit;
  final double? width;
  final double? height;
  final ImageErrorWidgetBuilder? errorBuilder;

  const AppImage(
    this.source, {
    super.key,
    this.fallbackAsset,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (ImageService.isDataUrl(source)) {
      return Image.memory(
        ImageService.decode(source),
        fit: fit,
        width: width,
        height: height,
        gaplessPlayback: true,
        errorBuilder: (context, error, stack) => fallbackAsset != null
            ? _asset(fallbackAsset!)
            : (errorBuilder?.call(context, error, stack) ?? _placeholder()),
      );
    }
    if (!ImageService.isRemote(source)) {
      return _asset(source.isEmpty ? fallbackAsset ?? '' : source);
    }
    return Image.network(
      source,
      fit: fit,
      width: width,
      height: height,
      // Use an <img> element on web when the host has no CORS headers
      webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.accent,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stack) => fallbackAsset != null
          ? _asset(fallbackAsset!)
          : (errorBuilder?.call(context, error, stack) ?? _placeholder()),
    );
  }

  Widget _asset(String path) {
    if (path.isEmpty) return _placeholder();
    return Image.asset(
      path,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: errorBuilder ?? (_, __, ___) => _placeholder(),
    );
  }

  Widget _placeholder() => Container(
        width: width,
        height: height,
        color: AppColors.surface,
        alignment: Alignment.center,
        child: const Icon(
          Icons.image_not_supported,
          color: AppColors.textSecondary,
          size: 48,
        ),
      );
}
