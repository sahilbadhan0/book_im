
import 'package:book_im/features/author/data/model/event.dart';
import 'package:flutter/foundation.dart';

abstract class AuthorState {}

class AuthorIdleState extends AuthorState {}

class FetchingAuthorState extends AuthorState {}

class FetchAuthorSuccessState extends AuthorState {
  List<Authors> events;
  FetchAuthorSuccessState({@required this.events});
}

class AuthorErrorState extends AuthorState {
  String message;
  AuthorErrorState({this.message});
}
