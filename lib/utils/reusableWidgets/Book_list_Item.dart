import 'package:book_im/features/books/data/model/book.dart';
import 'package:book_im/features/books/ui/book_detail.dart';
import 'package:book_im/utils/ReusableWidgets.dart';
import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  final Books book;

  BookListItem({this.book});

  @override
  Widget build(BuildContext context) {
    Size size = getScreenSize(context: context);
    return new InkWell(
      onTap: () {
        print("tappiing");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BookDetail()));
      },
      child: Material(
        elevation: 0.4,
        // type: MaterialType.card,

        // margin: EdgeInsets.symmetric(horizontal: size.width*0.015),
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
            width: size.width * 0.4,
            alignment: Alignment.center,
            child: getCachedNetworkImage(
              url: book?.image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
