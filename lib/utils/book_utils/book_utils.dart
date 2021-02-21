import 'dart:convert';

import 'package:book_im/features/localDatabase/LocalLocator.dart';
import 'package:book_im/features/localDatabase/localBook.dart';
import 'package:book_im/utils/app_theme/app_colors.dart';
import 'package:book_im/utils/database/locator_helper.dart';
import 'package:book_im/features/localDatabase/db_helper.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:sqflite/sqflite.dart';

class BookUtils {
  DatabaseHelper _dbHelper = new DatabaseHelper();

  openBook(String bookId) async {
    print("id ${bookId}");

    LocalBook localBook = await _dbHelper.getBookById(bookId);
    if (localBook != null) {
      print("book is not null");
      // dlList is a list of the downloads relating to this Book's id.
      // The list will only contain one item since we can only
      // download a book once. Then we use `dlList[0]` to choose the
      // first value from the string as out local book path

      String path = localBook.path;
      LocalLocator localLocator = await _dbHelper.getLocatorById(bookId);
      EpubLocator _locator = localLocator?.locator;
      print("locator${_locator}");
      EpubViewer.setConfig(
          identifier: 'androidBook',
          themeColor: AppColors.primaryColor,
          // scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
          scrollDirection: EpubScrollDirection.HORIZONTAL,
          enableTts: false,
          allowSharing: true,
          nightMode: false);

      EpubViewer.open(path, lastLocation: _locator != null ? _locator : null);
      EpubViewer.locatorStream.listen((event) async {
        // Get locator here
        print("Listen  --");
        Map json = jsonDecode(event);
        json['bookId'] = bookId;
        EpubLocator locator = EpubLocator.fromJson(json);
        // Save locator to your database
        int value = await _dbHelper
            .updateLocator(LocalLocator(bookId: bookId, locator: locator));
        if (value == 0) {
          await _dbHelper
              .addLocator(LocalLocator(bookId: bookId, locator: locator));
        }
      }
      );
    } else {
      print(" null");
    }
  }
}
