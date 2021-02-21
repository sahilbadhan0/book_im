import 'dart:convert';

import 'package:epub_viewer/epub_viewer.dart';


class LocalLocator {
  EpubLocator locator;
  String bookId;

  LocalLocator(
      {this.bookId,this.locator});

  LocalLocator.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    locator =json['locator_data']==null?null: EpubLocator?.fromJson(jsonDecode(json['locator_data']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['book_id']=this.bookId;
    if(this.locator!=null){
      data['locator_data']=jsonEncode(this.locator?.toJson());
    }

    return data;
  }
}