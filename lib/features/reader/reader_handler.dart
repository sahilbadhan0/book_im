import 'dart:convert';

import 'package:book_im/utils/AssetStrings.dart';
import 'package:book_im/utils/app_theme/appTheme.dart';
import 'package:book_im/utils/app_theme/app_colors.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';

class ReaderHandler{
  openReader(){


    EpubViewer.setConfig(

      themeColor: AppColors.primaryColor,
      identifier: "iosBook",
      scrollDirection: EpubScrollDirection.HORIZONTAL,
      allowSharing: false,
      enableTts: true,

    );
    EpubViewer.openAsset(

      AssetStrings.pubFle,
      lastLocation: EpubLocator.fromJson({
        "bookId": "iosBook",
        "href": "/OEBPS/ch06.xhtml",
        "created": 1539934158390,
        "locations": {
          "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
        }
      }), // first page will open up if the value is null
    );



// Get locator which you can save in your database
    EpubViewer.locatorStream.listen((locator) {
      print('LOCATOR: ${EpubLocator?.fromJson(jsonDecode(locator))}');
      // convert locator from string to json and save to your database to be retrieved later
    });
  }

/*


     // * @bookPath
     // * @lastLocation (optional and only android)
     // *

    EpubViewer.open(
      'bookPath',
      lastLocation: EpubLocator.fromJson({
        "bookId": "2239",
        "href": "/OEBPS/ch06.xhtml",
        "created": 1539934158390,
        "locations": {
          "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
        }
      }), // first page will open up if the value is null
    );
*/

}