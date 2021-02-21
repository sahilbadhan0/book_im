import 'package:book_im/features/author/bloc/demo_bloc.dart';
import 'package:book_im/features/author/bloc/demo_event.dart';
import 'package:book_im/features/author/bloc/demo_state.dart';
import 'package:book_im/features/author/data/model/event.dart';
import 'package:book_im/utils/ReusableWidgets.dart';
import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:book_im/utils/app_theme/app_colors.dart';
import 'package:book_im/utils/reusableWidgets/AlphabeticListView.dart';
import 'package:book_im/utils/reusableWidgets/custom_loader.dart';
import 'package:book_im/utils/reusableWidgets/paginationLoader.dart';
import 'package:book_im/utils/reusableWidgets/searchField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'author_detail.dart';

class AuthorScreen extends StatefulWidget {
  @override
  _AuthorScreenState createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  //props

  double _horizontalPadding = 20.0;
  bool gotPatrons = false;

  AuthorBloc _authorsBloc;
  List<Authors> authorsList = [];
  int currentPage = 1;
  int perPageCount = 1;
  ScrollController _patronScrollController = ScrollController();
  ValueNotifier<bool> isLoading = new ValueNotifier<bool>(false);

  //getters
  Widget get getHeader {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(
        "Wish List",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black45,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget get getAuthor {
    Size size = getScreenSize(context: context);

//    return ListView.builder(
//      controller: _patronScrollController,
//      padding: EdgeInsets.symmetric(horizontal: 8),
//      itemCount: authorsList?.length + 1,
//      itemBuilder: (context, i) {
//        return i == authorsList.length
//            ? PaginationLoader(
//          loaderNotifier: isLoading,
//        )
//            : getItem(author: authorsList[i]);
//      },
//    );

    // Returns alphabetic item
    _getAlphabeticItem({@required Authors author}) {
      return new InkWell(
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new AuthorDetail();
          }));
        },
        child: new Row(
          children: [
            new ClipRRect(
              borderRadius: BorderRadius.circular(
                getScreenSize(context: context).width * 0.06,
              ),
              child: new Container(
                width: getScreenSize(context: context).width * 0.1,
                height: getScreenSize(context: context).width * 0.1,
                color: AppColors.primaryColor,
                child: getCachedNetworkImage(
                  url: author?.profilePictureUrl,
                  fit: BoxFit.cover,
                  defaultImage: new Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            new Expanded(
              child: new Padding(
                padding: new EdgeInsets.symmetric(
                    horizontal: getScreenSize(context: context).width * 0.04),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      ((author?.name?.first ?? "") +
                                  " " +
                                  (author?.name?.last ?? ""))
                              ?.trim() ??
                          "-",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    new Text(
                      ((author?.address ?? "")?.trim() ?? "-"),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return new RefreshIndicator(
      color: AppColors.primaryColor.withOpacity(0.1),
      child: new AlphabeticListView(
        controller: _patronScrollController,
        headerContentItemBuilder: (data) {
          return _getAlphabeticItem(author: data);
        },
        alphabeticMappedData: {
          "A": authorsList,
          "B": authorsList,
          "C": authorsList,
          "D": authorsList,
          "E": authorsList,
          "F": authorsList,
          "G": authorsList,
          "H": authorsList,
          "I": authorsList,
          "J": authorsList,
          "K": authorsList,
          "L": authorsList,
          "M": authorsList,
          "N": authorsList,
          "O": authorsList,
          "P": authorsList,
          "Q": authorsList,
          "R": authorsList,
          "S": authorsList,
          "T": authorsList,
          "U": authorsList,
          "V": authorsList,
          "W": authorsList,
          "X": authorsList,
          "Y": authorsList,
          "Z": authorsList,
        },
      ),
      onRefresh: () async {
        fetchAuthor();
      },
    );
  }

  Widget getItem({Authors author}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 100,
      width: 100,
      color: Colors.yellow,
    );
  }

  //get patron sections

  Widget get getPatronsSection {
    return BlocBuilder<AuthorBloc, AuthorState>(builder: (context, state) {
      return Builder(
        builder: (context) {
          Widget _child;
          if (state is FetchAuthorSuccessState) {
            setAuthroList(state);

            _child = getAuthor;
          } else if (state is FetchingAuthorState || state is AuthorIdleState) {
            _child = CustomLoader();
          } else if (state is AuthorErrorState && !gotPatrons) {
            _child = getNoDataView(
                msg: state?.message,
                onRetry: () {
                  fetchAuthor();
                });
          } else {
            _child = getAuthor;
          }

          return _child;
        },
      );
    });
  }

  get getPage {
    return Scaffold(
        appBar: getAppThemedAppBar(context, titleText: "Authors"),
        body: new Column(
          children: [
            new Padding(
              padding: new EdgeInsets.all(
                getScreenSize(context: context).width * 0.045,
              ),
              child: SearchField(),
            ),
            new Expanded(child: getPatronsSection),
          ],
        ));
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
      _authorsBloc = BlocProvider.of<AuthorBloc>(context);
      fetchAuthor();
    }
  }

  @override
  Widget build(BuildContext context) {
    return getPage;
  }

  //other
  //fetch patrons
  fetchAuthor() {
    _authorsBloc.add(FetchAuthor(
        // currentPage: currentPage,
        ));
    // _homeBloc.add(FetchNotifications());
  }

  //set patrons data
  setAuthroList(FetchAuthorSuccessState state) {
    gotPatrons = true;

    if (currentPage == 1) {
      authorsList = state?.events ?? [];
      perPageCount = 10; //state?.patronList?.length ?? 0;todo
    } else {
      authorsList.addAll(state?.events);
    }
    isLoading.value = false;
  }

  //pagination logic
  _paginationLogic() async {
    if (_patronScrollController.position.maxScrollExtent ==
        _patronScrollController.offset) {
      print("totalRecode ${authorsList?.length} " +
          "current page ${currentPage}  perpageCount ${perPageCount}");

      print("Paginatig");
      if ((authorsList?.length ?? 0) >= (perPageCount * currentPage ?? 0)) {
        if (!isLoading.value) //is not loading
        {
          isLoading.value = true;
          currentPage++;
          fetchAuthor();
        }
      }
    }
  }
}
