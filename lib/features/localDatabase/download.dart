import 'package:book_im/features/auth/data/model/fb_profile.dart';
import 'package:book_im/features/localDatabase/db_helper.dart';
import 'package:book_im/features/localDatabase/localBook.dart';
import 'package:book_im/utils/AssetStrings.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadFile{
  DatabaseHelper _dbHelper= new DatabaseHelper();
  Future downloadFile(BuildContext context, String url, String filename) async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      print("granted");
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
     await startDownload(context, url, filename);
    } else {
      print("not granted");
      await startDownload(context, url, filename);
    }

    // startDownload(context, url, filename);
  }


  startDownload(BuildContext context, String url, String filename) async {
   /* Directory appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      Directory(appDocDir.path.split('Android')[0] + 'book_im')
          .createSync();
    }

    String path = Platform.isIOS
        ? appDocDir.path + '/$filename.epub'
        : appDocDir.path.split('Android')[0] +
        '${'book_im'}/$filename.epub';*/
    String dir = (await getApplicationDocumentsDirectory()).path;
    String path = dir+"/$filename.epub";

    print(path);
    File file = File(path);
    if (!await file.exists()) {
      await file.create();
    } else {
      await file.delete();
      await file.create();
    }

    var bytes = await rootBundle.load(AssetStrings.pubFle);

      final buffer = bytes.buffer;
       await  file.writeAsBytes(
          buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

       print("written");

    await _dbHelper.addBook(LocalBook(
      id: "book_1",
      name: "abc",
      path: path,
      image: "img",
      size: "10",
    ));


   /* showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => DownloadAlert(
        url: url,
        path: path,
      ),
    ).then((v) {
      // When the download finishes, we then add the book
      // to our local database
      if (v != null) {
        addDownload(
          {
            'id': entry.id.t.toString(),
            'path': path,
            'image': '${entry.link[1].href}',
            'size': v,
            'name': entry.title.t,
          },
        );
      }*/
    // });
  }
}