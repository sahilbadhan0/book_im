import 'package:book_im/features/books/bloc/demo_bloc.dart';
import 'package:book_im/features/books/bloc/demo_event.dart';
import 'package:book_im/features/books/bloc/demo_state.dart';
import 'package:book_im/features/books/data/model/book.dart';
import 'package:book_im/features/books/ui/book_detail.dart';

import 'package:book_im/utils/ReusableWidgets.dart';
import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:book_im/utils/app_theme/app_colors.dart';
import 'package:book_im/utils/reusableWidgets/custom_loader.dart';
import 'package:book_im/utils/reusableWidgets/searchField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBooksScreen extends StatefulWidget {
  @override
  _SearchBooksScreenState createState() => _SearchBooksScreenState();
}

class _SearchBooksScreenState extends State<SearchBooksScreen> {
  //Props
  bool _gotData = false;
  BooksBloc booksBloc;
  List<Books> booksList = [];

  get getBooksListView {
    double width = getScreenSize(context: context).width;
    double height = getScreenSize(context: context).height;
    return (booksList?.isEmpty)
        ? getNoDataView(
            msg: "No Physical Books found",
            onRetry: () {
              fetchBooks();
            })
        : ListView.separated(
            padding: EdgeInsets.only(
                left: width * 0.02,
                right: width * 0.02, top: height * 0.02),
            itemCount: booksList?.length ?? 0,
            separatorBuilder: (context, i) {
              return SizedBox(
                height: height * 0.02,
              );
            },
            itemBuilder: (context, i) {
              return getBooksItem(books: booksList[i]);
            });
  }

  //State methods

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_gotData) {
      booksBloc = BlocProvider.of<BooksBloc>(context);
      fetchBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          getPage,
          BlocListener<BooksBloc, BooksState>(
              child: Container(
                height: 0,
                width: 0,
              ),
              listener: (context, state) async {
                if (state is BooksErrorState) {
                  showAlert(
                      context: context,
                      titleText: "Error",
                      message: state?.message ?? "",
                      actionCallbacks: {"Ok": () {}});
                }
              })
        ],
      ),
    );
  }

  Widget get getPage {
    double height = getScreenSize(context: context).height;
    return GestureDetector(
      onTap: () {
        closeKeyboard(context: context, onClose: () {});
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(icon: Icon(Icons.arrow_back,color: AppColors.primaryColor,), onPressed: (){
              Navigator.pop(context);

            }),
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.02, left: 10, right: 10, bottom: 4),
              child: SearchField(),
            ),
            Expanded(child: getBooksBuilder),
          ],
        ),
      ),
    );
  }

  Widget get getBooksBuilder {
    return BlocBuilder<BooksBloc, BooksState>(builder: (context, state) {
      return Builder(
        builder: (context) {
          Widget _child;
          if (state is FetchBookSuccessState) {
            setData(state: state);
            _child = getBooksListView;
          } else if (state is FetchingBooksState || state is BooksIdleState) {
            _child = CustomLoader();
          } else if (state is BooksErrorState && !_gotData) {
            _child = getNoDataView(
                msg: state?.message,
                onRetry: () {
                  fetchBooks();
                });
          } else {
            _child = getBooksListView;
          }

          return _child;
        },
      );
    });
  }

  Widget getBooksItem({Books books}) {
    double width = getScreenSize(context: context).width;
    double height = getScreenSize(context: context).height;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BookDetail()));
      },
      child: Card(
          color: AppColors.listBlue,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: height * 0.2,
                      width: height * 0.14,
                      child: getCachedNetworkImage(url: "", fit: BoxFit.cover),
                    ),
                  ),
                  getSpacer(
                    width: width*0.03,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          books?.title ?? "",
                          style: TextStyle(
                              color: AppColors.primaryColor, fontSize: 18,fontWeight: FontWeight.w500),
                        ),
                        getSpacer(height: height * 0.02),
                        Text(
                          books?.author ?? "".toUpperCase(),
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                        getSpacer(height: height * 0.02),
                        getLikeDislike(
                          value: "620",
                        ),
                        getSpacer(height: height * 0.02),
                        getLikeDislike(value: "129", isLike: false),
                        Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }

  Widget getLikeDislike({isLike: true, String value}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isLike ? Icons.favorite : Icons.comment,
          color: AppColors.primaryColor,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          value ?? "",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        )
      ],
    );
  }

  //set data to Ui
  setData({FetchBookSuccessState state}) {
    _gotData = true;
    booksList = state?.events;
  }

  //fetch bookss
  fetchBooks() {
    booksBloc.add(FetchBooks());
  }

  //book mark books
  bookMark({Books books}) {
    // booksBloc.add(BookmarkBooks(books: books));
  }
}
