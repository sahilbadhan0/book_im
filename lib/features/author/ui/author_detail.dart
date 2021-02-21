import 'package:book_im/features/books/bloc/demo_bloc.dart';
import 'package:book_im/features/books/data/event_repository.dart';
import 'package:book_im/features/books/data/model/book.dart';
import 'package:book_im/features/books/ui/book_detail.dart';
import 'package:book_im/features/books/ui/search_books.dart';
import 'package:book_im/utils/ReusableWidgets.dart';
import 'package:book_im/utils/UniversalFunctions.dart';
import 'package:book_im/utils/app_theme/app_colors.dart';
import 'package:book_im/utils/reusableWidgets/Book_list_Item.dart';
import 'package:book_im/utils/reusableWidgets/ExpandableText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorDetail extends StatefulWidget {
  @override
  _AuthorDetailState createState() => _AuthorDetailState();
}

class _AuthorDetailState extends State<AuthorDetail> {
  // Returns cover photo and profile pic
  get _getCoverPhotoAndProfilePic {
    return new Stack(
      overflow: Overflow.visible,
      alignment: Alignment.center,
      children: [
        new Container(
          width: getScreenSize(context: context).width,
          height: getScreenSize(context: context).width * 0.33,
          color: AppColors.kGrey.withOpacity(0.2),
          child: getCachedNetworkImage(
            url: "",
//              url: author?.profilePictureUrl,
            fit: BoxFit.cover,
            defaultImage: new Icon(
              Icons.image,
              color: Colors.white,
            ),
          ),
        ),
        new Positioned(
          bottom: -getScreenSize(context: context).width * 0.1,
          child: new ClipRRect(
            borderRadius: BorderRadius.circular(
              getScreenSize(context: context).width * 0.1,
            ),
            child: new Container(
              width: getScreenSize(context: context).width * 0.2,
              height: getScreenSize(context: context).width * 0.2,
              color: AppColors.primaryColor,
              child: getCachedNetworkImage(
                url: "",
//              url: author?.profilePictureUrl,
                fit: BoxFit.cover,
                defaultImage: new Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Return author details
  get _getAuthorDetails {
    // Return details label
    getDetailLabel({@required String label, @required String value}) {
      return new RichText(
        text: new TextSpan(
          text: (label ?? "") + " - ",
          style: new TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          children: [
            new TextSpan(
              text: value ?? "",
              style: new TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getDetailLabel(label: "जन्म", value: "1958"),
        getDetailLabel(label: "जन्मस्थान", value: "Mundkothi, Darjling"),
        getDetailLabel(label: "शिक्षा", value: "M.A., PHD (Nepali)"),
      ],
    );
  }

  // Returns Author description
  get _getAuthorDescprition {
    return new Text(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      style: new TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
    );
  }

  // Returns books section
  get _getBooksSection {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Text(
          "Books by Dr. Basudev Pulami",
          style: new TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        new Container(
          height: getScreenSize(context: context).width * 0.06,
        ),
        new Wrap(
          children: []..addAll(new List.generate(10, (index) {
              return new Padding(
                padding: new EdgeInsets.only(
                  right: index.isEven
                      ? getScreenSize(context: context).width * 0.075
                      : 0,
                  bottom: getScreenSize(context: context).width * 0.06,
                ),
                child: new InkWell(
                  onTap: () {
                    print("tappiing");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BookDetail()));
                  },
                  child: new Card(
                    elevation: 0.4,
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                        width: getScreenSize(context: context).width * 0.38,
                        height: getScreenSize(context: context).width * 0.6,
                        alignment: Alignment.center,
                        child: getCachedNetworkImage(
                          url: "",
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              );
            })),
        ),
      ],
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
        appBar: getAppThemedAppBar(context, titleText: "Dr. Basudev Putami"),
        body: new SingleChildScrollView(
          child: new SafeArea(
            child: new Column(
              children: [
                _getCoverPhotoAndProfilePic,
                new Container(
                  height: getScreenSize(context: context).width * 0.1,
                ),
                new Padding(
                  padding: new EdgeInsets.symmetric(
                    horizontal: getScreenSize(context: context).width * 0.08,
                    vertical: getScreenSize(context: context).width * 0.06,
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _getAuthorDetails,
                      new Container(
                        height: getScreenSize(context: context).width * 0.03,
                      ),
                      _getAuthorDescprition,
                      new Container(
                        height: getScreenSize(context: context).width * 0.04,
                      ),
                      _getBooksSection,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



}
