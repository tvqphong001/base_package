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
  const AppImage(
    this.data, {
    Key? key,
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
        super(key: key);

  const AppImage.asset(
    this.data, {
    Key? key,
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
        super(key: key);

  const AppImage.memory(
    this.dataMemory, {
    Key? key,
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
        super(key: key);

  const AppImage.pathFile(
    this.data, {
    Key? key,
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
        super(key: key);

  const AppImage.file(
    this.file, {
    Key? key,
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
        super(key: key);

  const AppImage.network(
    this.data, {
    Key? key,
    this.fit = BoxFit.contain,
    this.height,
    this.colorBlendMode,
    this.width,
    this.color,
    this.size,
  })  : isMemory = false,
        isFile = false,
        dataMemory = null,
        isNetwork = true,
        file = null,
        super(key: key);

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
          fit: fit,
          maxHeightDiskCache: 350,
          maxWidthDiskCache: 350,
          memCacheWidth: 100,
          colorBlendMode: colorBlendMode,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => Container(
                padding: const EdgeInsets.all(10),
                color: color,
                child: const Text('error load'),
              ),
          );
    } else {
      // common
      var splitPath = data.split('.');

      if (splitPath[splitPath.length - 1] == 'svg') {
        widget = SvgPicture.asset(
          data,
          fit: fit,
          color: color,
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
    try{
      return SizedBox(
        width: size??double.infinity,
        height: size??double.infinity,
        child: LayoutBuilder(
            builder: (context,size) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(size.maxWidth/2),
                child: AppImage(path,isNetwork: isNetwork),
              );
            }
        ),
      );
    }catch(e){
      logger.e(e);
      return const Placeholder();
    }
  }
}
