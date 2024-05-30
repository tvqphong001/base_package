import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

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

  static Future<PermissionStatus> checkPermissionStorage()async{
    late PermissionStatus resp ;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        resp =await Permission.storage.request();
      }  else {
        resp =await Permission.photos.request();
      }
    }else{
      resp =await Permission.storage.request();
    }

    return resp;
  }

  static Future<PermissionStatus> requestPermissionStorage()async{
    late PermissionStatus resp ;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        resp =await Permission.storage.request();
      }  else {
        resp =await Permission.photos.request();
      }
    }else{
      resp =await Permission.storage.request();
    }

    return resp;
  }
}
