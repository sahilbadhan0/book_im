import 'package:book_im/features/category/bloc/demo_bloc.dart';
import 'package:book_im/features/category/bloc/demo_event.dart';
import 'package:book_im/features/category/bloc/demo_state.dart';
import 'package:book_im/features/category/data/model/event.dart';
import 'package:book_im/features/category/ui/category_detail.dart';
import 'package:book_im/utils/AssetStrings.dart';
import 'package:book_im/utils/ReusableWidgets.dart';
import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:book_im/utils/app_theme/app_colors.dart';
import 'package:book_im/utils/reusableWidgets/custom_loader.dart';
import 'package:book_im/utils/reusableWidgets/searchField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTab extends StatefulWidget {
  @override
  _CategoryTabState createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  //Props
  bool _gotData = false;
  CategoryBloc categoryBloc;
  List<Category> categoryList = [];

  get getCategoryListView {
    double width = getScreenSize(context: context).width;
    double height = getScreenSize(context: context).height;
    return (categoryList?.isEmpty)
        ? getNoDataView(
            msg: "No Physical Category found",
            onRetry: () {
              fetchCategory();
            })
        : ListView.separated(
            padding: EdgeInsets.only(
                left: width * 0.02, right: width * 0.02, top: height * 0.02),
            itemCount: categoryList?.length ?? 0,
            separatorBuilder: (context, i) {
              return SizedBox(
                height: height * 0.02,
              );
            },
            itemBuilder: (context, i) {
              return getCategoryItem(category: categoryList[i]);
            });
  }

  //State methods

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_gotData) {
      categoryBloc = BlocProvider.of<CategoryBloc>(context);
      fetchCategory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          getPage,
          BlocListener<CategoryBloc, CategoryState>(
              child: Container(
                height: 0,
                width: 0,
              ),
              listener: (context, state) async {
                if (state is CategoryErrorState) {
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
    double height= getScreenSize(context: context).height;
    return GestureDetector(
      onTap: () {
        closeKeyboard(context: context, onClose: () {});
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: height*0.1, left: 10, right: 10, bottom: 4),
            child: SearchField(),
          ),
          Expanded(child: getCategoryBuilder),
        ],
      ),
    );
  }

  Widget get getCategoryBuilder {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      return Builder(
        builder: (context) {
          Widget _child;
          if (state is FetchItemSuccessState) {
            setData(state: state);
            _child = getCategoryListView;
          } else if (state is FetchingItemState || state is EventIdleState) {
            _child = CustomLoader();
          } else if (state is CategoryErrorState && !_gotData) {
            _child = getNoDataView(
                msg: state?.message,
                onRetry: () {
                  fetchCategory();
                });
          } else {
            _child = getCategoryListView;
          }

          return _child;
        },
      );
    });
  }

  Widget getCategoryItem({Category category}) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryDetail()));
      },
      child: Card(
          color: AppColors.primaryColor,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              alignment: Alignment.center,
              child: Text(
                category?.name ?? "".toUpperCase(),
                style: TextStyle(color: Colors.white),
              ))),
    );
  }

  //set data to Ui
  setData({FetchItemSuccessState state}) {
    _gotData = true;
    categoryList = state?.events;
  }

  //fetch categorys
  fetchCategory() {
    categoryBloc.add(FetchCategory());
  }

  //book mark category
  bookMark({Category category}) {
    // categoryBloc.add(BookmarkCategory(category: category));
  }
}
