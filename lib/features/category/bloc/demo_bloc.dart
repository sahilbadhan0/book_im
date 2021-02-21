import 'package:book_im/features/category/bloc/demo_event.dart';
import 'package:book_im/features/category/bloc/demo_state.dart';
import 'package:book_im/features/category/data/event_repository.dart';
import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:book_im/utils/app_messages.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository eventRepository;

  CategoryBloc({@required this.eventRepository}) : super(EventIdleState());

  @override
  CategoryState get initialState => EventIdleState();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    print("Event $event");


    // Create new Post
    if (event is FetchCategory) {

      //Fetch prayer listing
      yield FetchingItemState();
      try {
        bool isConnected =
        await checkInternetForPostMethod(onSuccess: () {}, onFail: () {});
        if (!isConnected) {
          yield CategoryErrorState(message: AppMessages.noInternet);
          return;
        }

        var x = await eventRepository.fetchEvents();
        print("got x ${x.toJson()}");
        yield FetchItemSuccessState(events: x?.docs);
      } catch (e, st) {
        print("Exception $e, \n$st");
        //todo
        yield CategoryErrorState(message: e.toString());
      }
    }

  }
}
