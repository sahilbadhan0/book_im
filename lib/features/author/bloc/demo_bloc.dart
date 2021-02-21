import 'package:book_im/features/author/bloc/demo_event.dart';
import 'package:book_im/features/author/bloc/demo_state.dart';
import 'package:book_im/features/author/data/event_repository.dart';
import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:book_im/utils/app_messages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  AuthorRepository eventRepository;

  AuthorBloc({@required this.eventRepository}) : super(AuthorIdleState());

  @override
  AuthorState get initialState => AuthorIdleState();

  @override
  Stream<AuthorState> mapEventToState(AuthorEvent event) async* {
    print("Event $event");


    // Create new Post
    if (event is FetchAuthor) {

      //Fetch prayer listing
      yield FetchingAuthorState();
      try {
        bool isConnected =
        await checkInternetForPostMethod(onSuccess: () {}, onFail: () {});
        if (!isConnected) {
          yield AuthorErrorState(message: AppMessages.noInternet);
          return;
        }

        var x = await eventRepository.fetchEvents();
        print("got x ${x.toJson()}");
        yield FetchAuthorSuccessState(events: x?.docs);
      } catch (e, st) {
        print("Exception $e, \n$st");
        //todo
        yield AuthorErrorState(message: e.toString());
      }
    }

  }
}
