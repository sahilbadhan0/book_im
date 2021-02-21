import 'package:book_im/features/books/bloc/demo_bloc.dart';
import 'package:book_im/features/books/bloc/demo_event.dart';
import 'package:book_im/features/books/bloc/demo_state.dart';
import 'package:book_im/features/books/data/model/book.dart';
import 'package:book_im/utils/AssetStrings.dart';
import 'package:book_im/utils/ReusableWidgets.dart';
import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:book_im/utils/app_theme/app_colors.dart';
import 'package:book_im/utils/reusableWidgets/Book_list_Item.dart';
import 'package:book_im/utils/reusableWidgets/custom_loader.dart';
import 'package:book_im/utils/reusableWidgets/paginationLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListView extends StatefulWidget {
  @override
  _WishListViewState createState() => _WishListViewState();
}

class _WishListViewState extends State<WishListView> {
  //props

  double _horizontalPadding = 20.0;
  bool gotPatrons = false;

  BooksBloc _booksBloc;
  List<Books> booksList = [];
  int currentPage = 1;
  int perPageCount = 1;
  ScrollController _patronScrollController = ScrollController();
  ValueNotifier<bool> isLoading = new ValueNotifier<bool>(false);

  //getters
  Widget get getHeader {
    Size size= getScreenSize(context: context);

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal:size.width*0.04),
      child: Text(
        "Wish List",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.darkGey,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget get getBooks {
    Size size = getScreenSize(context: context);
    return ListView.separated(
      controller: _patronScrollController,
      padding: EdgeInsets.symmetric(horizontal: size.width*0.04,vertical: 4),

      itemCount: booksList?.length + 1,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) {
        return i == booksList.length
            ? PaginationLoader(
          loaderNotifier: isLoading,
        )
            : BookListItem(book: booksList[i]);
      },
         separatorBuilder: (BuildContext context, int index) {
      return getSpacer(width:    size.width*0.03
      );
    },
    );
  }

  //get patron sections

  Widget get getPatronsSection {
    return BlocBuilder<BooksBloc, BooksState>(builder: (context, state) {
      return Builder(
        builder: (context) {
          Widget _child;
          if (state is FetchBookSuccessState) {
            setPatronList(state);

            _child = getBooks;
          } else if (state is FetchingBooksState || state is BooksIdleState) {
            _child = CustomLoader();
          } else if (state is BooksErrorState && !gotPatrons) {
            _child = getNoDataView(
                msg: state?.message,
                onRetry: () {
                  fetchBooks();
                });
          } else {
            _child = getBooks;
          }

          return _child;
        },
      );
    });
  }

//State Methods

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _patronScrollController.addListener(_paginationLogic);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!gotPatrons) {
      _booksBloc = BlocProvider.of<BooksBloc>(context);
      fetchBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getHeader,
        SizedBox(
          height: 10,
        ),
        Container(
            height: getScreenSize(context: context).height * 0.35,
            child: getPatronsSection),
      ],
    );
  }

  //other
  //fetch patrons
  fetchBooks() {
    _booksBloc.add(FetchBooks(
      currentPage: currentPage,
    ));
    // _homeBloc.add(FetchNotifications());
  }

  //set patrons data
  setPatronList(FetchBookSuccessState state) {
    gotPatrons = true;

    if (currentPage == 1) {
      booksList = state?.events ?? [];
      perPageCount = 10; //state?.patronList?.length ?? 0;todo
    } else {
      booksList.addAll(state?.events);
    }
    isLoading.value = false;
  }

  //pagination logic
  _paginationLogic() async {
    if (_patronScrollController.position.maxScrollExtent ==
        _patronScrollController.offset) {
      print("totalRecode ${booksList?.length} " +
          "current page ${currentPage}  perpageCount ${perPageCount}");

      print("Paginatig");
      if ((booksList?.length ?? 0) >= (perPageCount * currentPage ?? 0)) {
        if (!isLoading.value) //is not loading
            {
          isLoading.value = true;
          currentPage++;
          fetchBooks();
        }
      }
    }
  }
}
