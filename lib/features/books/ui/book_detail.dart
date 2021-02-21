import 'package:book_im/features/books/bloc/demo_bloc.dart';
import 'package:book_im/features/books/data/event_repository.dart';
import 'package:book_im/features/books/ui/search_books.dart';
import 'package:book_im/features/localDatabase/db_helper.dart';
import 'package:book_im/features/localDatabase/download.dart';
import 'package:book_im/features/localDatabase/localBook.dart';
import 'package:book_im/utils/ReusableWidgets.dart';
import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:book_im/utils/app_theme/app_colors.dart';
import 'package:book_im/utils/book_utils/book_utils.dart';
import 'package:book_im/utils/reusableWidgets/ExpandableText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetail extends StatefulWidget {
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  //getters
  Widget get getBookCover {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 0.4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: getScreenSize(context: context).height * 0.35,
        width: getScreenSize(context: context).width * 0.35,
        child: getCachedNetworkImage(url: "", fit: BoxFit.cover),
      ),
    );
  }

  Widget get geAuthor {
    double space = getScreenSize(context: context).height * 0.02;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSpacer(height: space / 2),
        Text(
          "Shabd Ko Khelo",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: space,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Center(
                child: Icon(Icons.person),
              ),
            ),
            SizedBox(
              width: space,
            ),
            Expanded(
              child: Text(
                "Dr. Basudev Pulami",
                style: TextStyle(color: AppColors.darkGey, fontSize: 16),
              ),
            )
          ],
        ),
        SizedBox(
          height: space,
        ),
        getKeyValue(key: "Key", value: "Value"),
        SizedBox(
          height: space,
        ),
        getKeyValue(key: "Key", value: "Value"),
        SizedBox(
          height: space * 2,
        ),
        Wrap(
          alignment: WrapAlignment.end,
          spacing: space,
          runSpacing: space,
          children: [
            getLikeDislike(value: "609", isLike: true),
            getLikeDislike(value: "120", isLike: false)
          ],
        ),
      ],
    );
  }

  Widget get getBookHeader {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getBookCover,
        SizedBox(width: getScreenSize(context: context).width * 0.06),
        Expanded(child: geAuthor),
      ],
    );
  }

  Widget get getDescription {
    String txt =
        "When we talk about cover desing , we often talk about the color pallete,"
        " typography and use of images . What we rarely mention";
    return ExpandableText(
      txt,
      maxLines: 2,
      collapseText: "LESS",
      expandText: "MORE",
      textAlign: TextAlign.center,
    );
    return Text(
      "When we talk about cover desing , we often talk about the color pallete,"
      " typography and use of images . What we rarely mention",
      maxLines: null,
    );
  }

  Widget get getCommentComposer {
    return Row(
      children: [
        Expanded(
          child: appThemedTextField(
            hint: "Say Something",
            focusNode: null,
            controller: TextEditingController(),
            context: context,
          ),
        ),
        getAppThemedIconButton(
          title: "dd",
          iconData: Icons.arrow_forward_outlined,
          onPress: () {
            print("Naviagated ");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BlocProvider(
                  create: (BuildContext context) =>
                      BooksBloc(eventRepository: BooksRepository()),
                  child: SearchBooksScreen());
            }));
          },
        )
      ],
    );
  }

  Widget get getAddCommentWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "COMMENTS",
          style: TextStyle(
              color: AppColors.darkGey,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        getSpacer(height: getScreenSize(context: context).height * 0.02),
        getCommentComposer
      ],
    );
  }

  Widget get getActionButtons {
    return Row(
      children: [
        Expanded(
          child: getAppThemedButton(
              title: "READ",
              isFilled: true,
              onPress: () {
                readBook();
              }),
        ),
        SizedBox(width: 10),
        Expanded(
          child: getAppThemedButton(
              title: "+ LIBRARY",
              onPress: () {
                download();
              }),
        )
      ],
    );
  }

  Widget get getBookDetail {
    double height = getScreenSize(context: context).height;
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            getBookHeader,
            getSpacer(height: height * 0.03),
            getActionButtons,
            getSpacer(height: height * 0.03),
            getDescription,
            getSpacer(height: height * 0.03),
            getAddCommentWidget,
            getSpacer(height: height * 0.03),
            getCommentList,
          ],
        ));
  }

  Widget get getCommentList {
    return Column(
      children: List.generate(10, (index) => getCommentItem()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        closeKeyboard(context: context, onClose: () {});
      },
      child: Scaffold(
        // backgroundColor:Colors.grey.shade300,
        appBar: getAppThemedAppBar(context, titleText: "Shabd ko"),
        body: getBookDetail,
      ),
    );
  }

  //widget
  Widget getKeyValue({String key, String value}) {
    return Row(
      children: [
        Text(
          key ?? "",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.darkGey,
              fontSize: 16),
        ),
        Text(": "),
        Expanded(
            child: Text(
          value ?? "",
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: AppColors.darkGey,
              fontSize: 16),
        ))
      ],
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
        Text(
          value ?? "",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        )
      ],
    );
  }

  Widget getCommentItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: getScreenSize(context: context).width * 0.15,
            width: getScreenSize(context: context).width * 0.15,
            color: AppColors.primaryColor,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "John Doe",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                getSpacer(height: 8),
                Text("2h ago",
                    style:
                        TextStyle(color: AppColors.primaryColor, fontSize: 12)),
                getSpacer(height: 8),
                Text("Comment on book dfd dkdlfldsflfd jlfjlfdjf   ",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  readBook() async {
    DatabaseHelper dBhelper = DatabaseHelper();
    List<LocalBook> loclaBook = await dBhelper.getBookList();

    if (loclaBook?.isNotEmpty) {
      BookUtils().openBook("book_1"); //book  static
    } else {
      showAlert(
          context: context,
          message: "Please download book",
          titleText: "Success",
          actionCallbacks: {
            "ok": () {
              Future.delayed(Duration(seconds: 2));
              // openBook();
            }
          });
    }
  }

  openBook() {
    BookUtils().openBook("book_1");
  }

  void download() async {

    await DownloadFile().downloadFile(context, "url", "abc");
  }
}
