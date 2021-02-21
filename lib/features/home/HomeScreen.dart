import 'package:book_im/features/books/bloc/demo_bloc.dart';
import 'package:book_im/features/books/data/event_repository.dart';
import 'package:book_im/features/books/ui/book_list_view.dart';
import 'package:book_im/features/books/ui/wish_list_view.dart';
import 'package:book_im/utils/ReusableWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.03),
      appBar: getAppThemedAppBar(context, titleText: "BOOKiM"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            BlocProvider(
                create: (BuildContext context) =>
                    BooksBloc(eventRepository: BooksRepository()),
                child: BooksListingView()),
            BlocProvider(
                create: (BuildContext context) =>
                    BooksBloc(eventRepository: BooksRepository()),
                child: WishListView()),
          ],
        ),
      ),
    );
  }
}
