
import 'package:book_im/features/demo/data/model/event.dart';
import 'package:flutter/foundation.dart';

abstract class DemoState {}

class EventIdleState extends DemoState {}

class FetchingItemState extends DemoState {}

class FetchItemSuccessState extends DemoState {
  List<Items> events;
  FetchItemSuccessState({@required this.events});
}

class DemoErrorState extends DemoState {
  String message;
  DemoErrorState({this.message});
}
