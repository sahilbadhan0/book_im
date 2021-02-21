import 'package:book_im/features/demo/data/event_repository.dart';
import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:book_im/utils/app_messages.dart';
import 'package:flutter/foundation.dart';
import 'demo_event.dart';
import 'demo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DemoBloc extends Bloc<DemoEvent, DemoState> {
  DemoRepository eventRepository;

  DemoBloc({@required this.eventRepository}) : super(EventIdleState());

  @override
  DemoState get initialState => EventIdleState();

  @override
  Stream<DemoState> mapEventToState(DemoEvent event) async* {
    print("Event $event");


    // Create new Post
    if (event is FetchEvent) {

      //Fetch prayer listing
      yield FetchingItemState();
      try {
        bool isConnected =
        await checkInternetForPostMethod(onSuccess: () {}, onFail: () {});
        if (!isConnected) {
          yield DemoErrorState(message: AppMessages.noInternet);
          return;
        }

        var x = await eventRepository.fetchEvents();
        print("got x ${x.toJson()}");
        yield FetchItemSuccessState(events: x?.data);
      } catch (e, st) {
        print("Exception $e, \n$st");
        //todo
        yield DemoErrorState(message: e.toString());
      }
    }

  }
}
