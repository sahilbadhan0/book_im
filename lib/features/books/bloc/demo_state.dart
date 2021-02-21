
import 'package:book_im/features/books/data/model/book.dart';
import 'package:flutter/foundation.dart';

abstract class BooksState {}

class BooksIdleState extends BooksState {}

class FetchingBooksState extends BooksState {}

class FetchBookSuccessState extends BooksState {
  List<Books> events;
  FetchBookSuccessState({@required this.events});
}

class BooksErrorState extends BooksState {
  String message;
  BooksErrorState({this.message});
}
