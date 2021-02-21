import 'package:book_im/features/books/bloc/demo_bloc.dart';
import 'package:book_im/features/books/data/event_repository.dart';
import 'package:book_im/features/books/ui/book_list_view.dart';
import 'package:book_im/features/books/ui/books_by_author.dart';
import 'package:book_im/features/books/ui/wish_list_view.dart';
import 'package:book_im/utils/ReusableWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetail extends StatefulWidget {
  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppThemedAppBar(context, titleText: "Category"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            BlocProvider(
                create: (BuildContext context) =>
                    BooksBloc(eventRepository: BooksRepository()),
                child: AuthorWiseListView(
                  author: "Nirdoshika Tamang",
                )),
            BlocProvider(
                create: (BuildContext context) =>
                    BooksBloc(eventRepository: BooksRepository()),
                child: AuthorWiseListView(
                  author: "Manoj Bogati",
                )),

          ],
        ),
      ),
    );
  }
}
