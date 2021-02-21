import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:book_im/utils/app_theme/app_colors.dart';
import '../UniversalFunctions.dart';

class AlphabeticListView<T> extends StatefulWidget {
  final Map<String, List<T>> alphabeticMappedData;
  final Widget Function(T) headerContentItemBuilder;
  final ScrollController controller;

  AlphabeticListView({
    Key key,
    @required this.controller,
    @required this.alphabeticMappedData,
    @required this.headerContentItemBuilder,
  }) : super(key: key);

  @override
  _AlphabeticListViewState createState() => _AlphabeticListViewState();
}

class _AlphabeticListViewState<T> extends State<AlphabeticListView> {
  // Controllers
  ScrollController _listScrollController;

  // UI props.
  bool _showScrolledLetterLabel = false;
  int _scrolledToLetterIndex;

  // Global keys
  List<GlobalKey> alphabeticHeaderRepaintKeys = [];
  GlobalKey alphabeticScrollRepaintKey = new GlobalKey();

  // Getters

  // Returns data list
  get _getDataList {
    return new SingleChildScrollView(
      controller: _listScrollController,
      physics: ClampingScrollPhysics(),
      child: new Column(
        children: <Widget>[]..addAll(new List.generate(
              widget.alphabeticMappedData?.length ?? 0, (int index) {
            String headerTitle =
                widget.alphabeticMappedData?.keys?.toList()[index] ?? "";

            List<T> itemsList = widget.alphabeticMappedData[headerTitle] ?? [];
            alphabeticHeaderRepaintKeys.add(new GlobalKey());

            return new Offstage(
              offstage: itemsList?.isEmpty ?? true,
              child: new RepaintBoundary(
                key: alphabeticHeaderRepaintKeys[index],
                child: new Padding(
                  padding: new EdgeInsets.only(
                    // padding to last item
                    bottom: index ==
                            ((widget.alphabeticMappedData?.length ?? 0) - 1)
                        ? 62.0
                        : 0.0,
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        color: AppColors.listBlue.withOpacity(0.7),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 7.0,
                        ),
                        child: Text(
                          headerTitle?.toUpperCase() ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      new Column(
                        children: <Widget>[]..addAll(
                            new List.generate(
                              itemsList?.length ?? 0,
                              (int i) {
                                bool showBorder =
                                    i != ((itemsList?.length ?? 0) - 1);
                                T item = itemsList[i];
                                return new Column(
                                  children: [
                                    new Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16,
                                      ),
                                      child: widget
                                              .headerContentItemBuilder(item) ??
                                          new Container(),
                                    ),
                                    new Container(
                                      height: 1.0,
                                      width: double.infinity,
                                      color:
                                          AppColors.listBlue.withOpacity(0.7),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
      ),
    );
  }

  // Returns alphabetic scrollbar
  get _getAlphabeticScrollbar {
    // Scrolls to indexed based header
    void _moveToSpecificHeader({@required int index}) async {
      double headerOffset = 0.0;
      if (index > 0) {
        for (int i = 0; i < index; i++) {
          RenderRepaintBoundary boundary =
              alphabeticHeaderRepaintKeys[i].currentContext.findRenderObject();
          headerOffset += boundary?.size?.height ?? 0.0;
        }
      }

      await Future.delayed(new Duration(
        milliseconds: 100,
      ));

      _listScrollController?.animateTo(
        headerOffset,
        duration: new Duration(
          milliseconds: 100,
        ),
        curve: Curves.ease,
      );
    }

    return new GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) {
        RenderRepaintBoundary boundary =
            alphabeticScrollRepaintKey.currentContext.findRenderObject();
        double _alphabeticScrollHeight = boundary?.size?.height ?? 0.0;
        double _letterHeight = (_alphabeticScrollHeight /
                widget.alphabeticMappedData?.keys?.toList()?.length) ??
            0.0;
        int letterIndexReached = details.localPosition.dy ~/ _letterHeight;

        setState(() {
          if (letterIndexReached < 0) {
            _scrolledToLetterIndex = 0;
          } else if (letterIndexReached >
              ((widget.alphabeticMappedData?.keys?.toList()?.length ?? 1) -
                  1)) {
            _scrolledToLetterIndex =
                (widget.alphabeticMappedData?.keys?.toList()?.length ?? 1) - 1;
          } else {
            _scrolledToLetterIndex = letterIndexReached;
          }
        });

        _moveToSpecificHeader(index: _scrolledToLetterIndex);
      },
      onVerticalDragStart: (_) {
        setState(() {
          _showScrolledLetterLabel = true;
        });
      },
      onVerticalDragEnd: (_) {
        setState(() {
          _showScrolledLetterLabel = false;
        });
      },
      child: new RepaintBoundary(
        key: alphabeticScrollRepaintKey,
        child: new SingleChildScrollView(
//          physics: NeverScrollableScrollPhysics(),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: []..addAll(
                new List.generate(
                  widget.alphabeticMappedData?.keys?.toList()?.length ?? 0,
                  (index) {
                    String _letter =
                        widget.alphabeticMappedData?.keys?.toList()[index];
                    List<T> itemsList =
                        widget.alphabeticMappedData[_letter] ?? [];
                    return new Offstage(
                      offstage: itemsList?.isEmpty ?? true,
                      child: new InkWell(
                        onTap: () async {
                          _moveToSpecificHeader(index: index);
                        },
                        child: new Padding(
                          padding: new EdgeInsets.symmetric(
                            vertical:
                                getScreenSize(context: context).height * 0.0025,
                            horizontal:
                                getScreenSize(context: context).width * 0.03,
                          ),
                          child: new Text(
                            (_letter ?? "")?.toUpperCase(),
                            style: new  TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.listBlue.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ),
        ),
      ),
    );
  }

  // Returns scrolled letter label
  get _getScrolledLetterLabel {
    return new Visibility(
      visible: _showScrolledLetterLabel,
      child: new Center(
        child: new ClipRRect(
          borderRadius: BorderRadius.circular(
              getScreenSize(context: context).width * 0.03),
          child: new BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: new Container(
              alignment: Alignment.center,
              color: Colors.black.withOpacity(0.1),
              width: getScreenSize(context: context).width * 0.3,
              height: getScreenSize(context: context).width * 0.3,
              child: new Text(
                widget.alphabeticMappedData?.keys
                    ?.toList()[_scrolledToLetterIndex ?? 0]
                    .toUpperCase(),
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _setDefaults();
    super.initState();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  // Builds screen
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Expanded(
              child: _getDataList,
            ),
            _getAlphabeticScrollbar,
          ],
        ),
        _getScrolledLetterLabel,
      ],
    );
  }

  // Methods

  // Sets defaults
  void _setDefaults() {
    _listScrollController =/* ScrollController();*/widget.controller;

    // _listScrollController.addListener(() {
    //
    // });

  }

  // Disposes controllers
  void _dispose() {
    _listScrollController?.dispose();
  }
}
