import 'package:cached_network_image/cached_network_image.dart';

import '../../base.dart';

class AppImage extends StatelessWidget {
  final dynamic data;
  final BoxFit fit;
  final Color? color;
  final double? height;
  final double? size;
  final double? width;
  final bool isMemory;
  final Uint8List? dataMemory;
  final File? file;
  final BlendMode? colorBlendMode;
  final bool isFile;
  final bool isNetwork;
  final bool isNetworkMax;
  final bool isNetworkIcon;
  final int? networkImgSize;
  final Widget? errorWidget; // only network
  final String? cacheKey;
  const AppImage(
      this.data, {
        super.key,
        this.fit = BoxFit.contain,
        this.height,
        this.width,
        this.colorBlendMode,
        this.color,
        this.size,
        this.isNetwork = false,
      })  : isMemory = false,
        dataMemory = null,
        isFile = false,
        file = null,
        isNetworkMax = false,
        isNetworkIcon = false,
        errorWidget = null,
        cacheKey = null,
        networkImgSize = null;

  const AppImage.asset(
      this.data, {
        super.key,
        this.fit = BoxFit.contain,
        this.height,
        this.colorBlendMode,
        this.width,
        this.color,
        this.size,
      })  : isMemory = false,
        dataMemory = null,
        isFile = false,
        isNetwork = false,
        file = null,
        isNetworkMax = false,
        isNetworkIcon = false,
        errorWidget = null,
        cacheKey = null,
        networkImgSize = null;

  const AppImage.memory(
      this.dataMemory, {
        super.key,
        this.fit = BoxFit.contain,
        this.height,
        this.colorBlendMode,
        this.width,
        this.color,
        this.size,
      })  : isMemory = true,
        data = '',
        isFile = false,
        isNetwork = false,
        file = null,
        isNetworkMax = false,
        isNetworkIcon = false,
        errorWidget = null,
        cacheKey = null,
        networkImgSize = null;

  const AppImage.pathFile(
      this.data, {
        super.key,
        this.fit = BoxFit.contain,
        this.height,
        this.colorBlendMode,
        this.width,
        this.color,
        this.size,
      })  : isMemory = false,
        isFile = true,
        dataMemory = null,
        isNetwork = false,
        file = null,
        isNetworkMax = false,
        isNetworkIcon = false,
        errorWidget = null,
        cacheKey = null,
        networkImgSize = null;

  const AppImage.file(
      this.file, {
        super.key,
        this.fit = BoxFit.contain,
        this.height,
        this.colorBlendMode,
        this.width,
        this.color,
        this.size,
      })  : isMemory = false,
        isFile = true,
        data = '',
        dataMemory = null,
        isNetwork = false,
        isNetworkMax = false,
        isNetworkIcon = false,
        errorWidget = null,
        cacheKey = null,
        networkImgSize = null;

  const AppImage.network(
      this.data, {
        super.key,
        this.fit = BoxFit.contain,
        this.height,
        this.colorBlendMode,
        this.width,
        this.color,
        this.size,
        this.errorWidget,
        this.isNetworkIcon = false,
        this.cacheKey,
        this.networkImgSize,
      })  : isMemory = false,
        isFile = false,
        dataMemory = null,
        isNetwork = true,
        file = null,
        isNetworkMax = false;

  const AppImage.networkIcon(
      this.data, {
        super.key,
        this.fit = BoxFit.contain,
        this.height,
        this.colorBlendMode,
        this.width,
        this.color,
        this.size,
        this.errorWidget,
        this.cacheKey,
      })  : isMemory = false,
        isFile = false,
        dataMemory = null,
        isNetwork = true,
        isNetworkIcon = true,
        file = null,
        isNetworkMax = false,
        networkImgSize = null;

  const AppImage.networkMax(
      this.data, {
        super.key,
        this.fit = BoxFit.contain,
        this.height,
        this.colorBlendMode,
        this.width,
        this.color,
        this.size,
        this.errorWidget,
        this.cacheKey,
      })  : isMemory = false,
        isFile = false,
        dataMemory = null,
        isNetwork = true,
        isNetworkIcon = false,
        file = null,
        isNetworkMax = true,
        networkImgSize = null;

  @override
  Widget build(BuildContext context) {
    late Widget widget;

    /* if (data is MediaData) {
      widget = ImageLoader(
        image: data,
        fit: fit,
        color: color,
      );
    } else */
    if (data is IconData) {
      widget = Icon(
        data,
        size: size,
        color: color,
      );
    } else if (isFile) {
      widget = Image.file(
        file ?? File(data),
        fit: fit,
        color: color,
      );
    } else if (isMemory) {
      widget = Image.memory(
        dataMemory!,
        fit: fit,
        color: color,
      );
    } else if (isNetwork) {
      widget = CachedNetworkImage(
        imageUrl: data,
        color: color,
        cacheKey: cacheKey,
        fit: fit,
        height: size ?? height,
        width: size ?? width,
        maxHeightDiskCache: networkImgSize != null
            ? networkImgSize!
            : isNetworkIcon
            ? 50
            : isNetworkMax
            ? null
            : 350,
        maxWidthDiskCache: networkImgSize != null
            ? networkImgSize!
            : isNetworkIcon
            ? 50
            : isNetworkMax
            ? null
            : 350,
        memCacheWidth: networkImgSize != null
            ? networkImgSize!
            : isNetworkIcon
            ? 50
            : isNetworkMax
            ? null
            : 100,
        colorBlendMode: colorBlendMode,
        placeholder: (context, url) => isNetworkMax
            ? const SizedBox()
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 40,
                      maxWidth: 40,
                    ),
                    child: const CircularProgressIndicator())),
          ],
        ),
        errorWidget: (context, url, error) {
          return errorWidget ??
              Container(
                padding: const EdgeInsets.all(10),
                color: color,
                child: const Text('error load'),
              );
        },
      );
    } else if (data == null) {
      widget = const SizedBox();
    } else {
      // common
      var splitPath = data.split('.');

      if (splitPath[splitPath.length - 1] == 'svg') {
        widget = SvgPicture.asset(
          data,
          fit: fit,
          colorFilter:
          color == null ? null : ColorFilter.mode(color!, colorBlendMode ?? BlendMode.srcIn),
        );
      } else {
        widget = Image.asset(
          data,
          fit: fit,
          color: color,
        );
      }
    }

    return SizedBox(
      height: size ?? height,
      width: size ?? width,
      child: widget,
    );
  }
}

class AppCircleImage extends StatelessWidget {
  final bool isNetwork;
  final String path;
  final double? size;
  const AppCircleImage({Key? key, required this.path, this.size})
      : isNetwork = false,
        super(key: key);
  const AppCircleImage.network({Key? key, required this.path, this.size})
      : isNetwork = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return SizedBox(
        width: size ?? double.infinity,
        height: size ?? double.infinity,
        child: LayoutBuilder(builder: (context, size) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(size.maxWidth / 2),
            child: isNetwork
                ? AppImage.networkMax(path, fit: BoxFit.cover)
                : AppImage(path, fit: BoxFit.cover),
          );
        }),
      );
    } catch (e) {
      logger.e(e);
      return const Placeholder();
    }
  }
}
