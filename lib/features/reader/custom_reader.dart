import 'package:book_im/features/localDatabase/db_helper.dart';
import 'package:book_im/features/localDatabase/download.dart';
import 'package:book_im/features/localDatabase/localBook.dart';
import 'package:book_im/features/reader/reader_handler.dart';
import 'package:book_im/utils/AssetStrings.dart';
import 'package:book_im/utils/ReusableWidgets.dart';
import 'package:book_im/utils/book_utils/book_utils.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';


class CustomReader extends StatefulWidget {
  @override
  _CustomReaderState createState() => _CustomReaderState();
}

class _CustomReaderState extends State<CustomReader> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppThemedAppBar(context,titleText: "Reader"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text("Open book"),
              onPressed: ()async{
            // ReaderHandler().openReader();
                List<LocalBook> list =await DatabaseHelper().getBookList();
                print("${list[0]?.toJson()}");
                BookUtils().openBook("book_1");
          }),
          RaisedButton(
              child: Text("DownloadBook"),
              onPressed: (){
                // DatabaseHelper().removeAllBooks();
                DownloadFile().downloadFile(context,"url" , "abc");
                
              })
        ],

      ),
    );
  }



}
