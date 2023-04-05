import 'package:image_picker/image_picker.dart';

import '../../../base.dart';

Future<XFile?> showBottomSheetImagePicker(
  BuildContext context, {
  String? textCamera,
  String? textGallery,
  String? textClose,
}) async {
  return await showModalBottomSheet<XFile?>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7), color: Colors.white),
              child: Column(
                children: [
                  // take picture
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Button(
                      onPressed: () async {
                        var result = await _takeImageFromGallery(
                            imageSource: ImageSource.camera);
                        if (result != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context, result);
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: 50,
                        child: Center(
                          child: TextApp(
                            textCamera ?? 'Choose Image from camera',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  // choose image
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Button(
                      onPressed: () async {
                        var result = await _takeImageFromGallery(
                            imageSource: ImageSource.gallery);
                        if (result != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context, result);
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: 50,
                        child: Center(
                          child: TextApp(
                            textGallery ?? 'Choose image from gallery',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Button(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white),
                child: Center(
                  child: TextApp(
                    textClose ?? 'Close',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    },
  );
}

Future<XFile?> _takeImageFromGallery({required ImageSource imageSource}) async {
  try {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(
      source: imageSource,
      imageQuality: 80,
      maxWidth: 200,
      maxHeight: 200,
    );
  } on PlatformException catch (e) {
    print(e);
    return null;
  }
}
