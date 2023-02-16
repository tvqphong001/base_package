import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Permission? permission;

  static Future checkCameraPermission(takeImage) async {
    permission = Permission.camera;
    var permissionStatus = await permission!.request();

    print(permissionStatus);

    switch (permissionStatus) {
      case PermissionStatus.granted:
        await takeImage();
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        if (Platform.isIOS) {
          await AppSettings.openAppSettings();
        } else {
          try {
            if (await Permission.camera.request().isGranted) {
              await takeImage();
            }
          } catch (e) {
            print(e);
          }
        }
        break;
      default:
        break;
    }
  }

  static Future checkBluetoothPermission(takeImage) async {
    permission = Permission.bluetooth;
    var permissionStatus = await permission!.request();

    print(permissionStatus);

    switch (permissionStatus) {
      case PermissionStatus.granted:
        await takeImage();
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        if (Platform.isIOS) {
          await AppSettings.openAppSettings();
        } else {
          try {
            if (await Permission.camera.request().isGranted) {
              await takeImage();
            }
          } catch (e) {
            print(e);
          }
        }
        break;
      default:
        break;
    }
  }
}
