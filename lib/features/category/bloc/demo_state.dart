
import 'package:book_im/features/category/data/model/event.dart';
import 'package:flutter/material.dart';

abstract class CategoryState {}

class EventIdleState extends CategoryState {}

class FetchingItemState extends CategoryState {}

class FetchItemSuccessState extends CategoryState {
  List<Category> events;
  FetchItemSuccessState({@required this.events});
}

class CategoryErrorState extends CategoryState {
  String message;
  CategoryErrorState({this.message});
}
