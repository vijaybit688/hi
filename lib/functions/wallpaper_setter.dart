import 'package:click2chat/functions/toastMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'internet_connection_checker.dart';

void downloadTask(BuildContext context, String fileName, String url) async {
  String path = '/storage/emulated/0/Download/';
  bool internetStatus = await getInternetStatus(context);
  if (internetStatus) {
    bool pathExistOrNot = await File('$path/$fileName').exists();
    if (pathExistOrNot) {
      toastMessage( "Image Is Already Downloaded");
    } else {
      try {
        final status = await Permission.storage.request();
        if (status.isGranted) {
          final id = await FlutterDownloader.enqueue(
            fileName: fileName,
            url: url, //widget.listOfUrl[index],
            savedDir: path,
            showNotification:
                true, // show download progress in status bar (for Android)
            openFileFromNotification:
                true, // click on notification to open downloaded file (for Android)
          );
          toastMessage(
              "Image Downloaded");
        } else {
          print('permission Denied');
        }
      } catch (e) {
        print("Exception Occur");
      }
    }
  } else {
    await checkConnection(context, '');
  }
}
