import 'package:book_im/features/books/bloc/demo_event.dart';
import 'package:book_im/features/books/bloc/demo_state.dart';
import 'package:book_im/features/books/data/event_repository.dart';

import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:book_im/utils/app_messages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksRepository eventRepository;

  BooksBloc({@required this.eventRepository}) : super(BooksIdleState());

  @override
  BooksState get initialState => BooksIdleState();

  @override
  Stream<BooksState> mapEventToState(BooksEvent event) async* {
    print("Event $event");


    // Create new Post
    if (event is FetchBooks) {

      //Fetch prayer listing
      yield FetchingBooksState();
      try {
        bool isConnected =
        await checkInternetForPostMethod(onSuccess: () {}, onFail: () {});
        if (!isConnected) {
          yield BooksErrorState(message: AppMessages.noInternet);
          return;
        }

        var x = await eventRepository.fetchEvents();
        print("got x ${x.toJson()}");
        yield FetchBookSuccessState(events: x?.docs);
      } catch (e, st) {
        print("Exception $e, \n$st");
        //todo
        yield BooksErrorState(message: e.toString());
      }
    }

  }
}
