// import 'package:epub_view/epub_view.dart';
// import 'package:flutter/material.dart';
//
// class CustomReader2 extends StatefulWidget {
//   @override
//   _CustomReader2State createState() => _CustomReader2State();
// }
//
// class _CustomReader2State extends State<CustomReader2> {
//
//   EpubController _epubController;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _epubController = EpubController(
//
//     );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Show actual chapter name
//         title: EpubActualChapter(
//           controller: _epubController,
//           builder: (chapterValue) => Text(
//             'Chapter ${chapterValue.chapter.Title ?? ''}',
//             textAlign: TextAlign.start,
//           ),
//         ),
//       ),
//       // Show table of contents
//       drawer: Drawer(
//         child: EpubReaderTableOfContents(
//           controller: _epubController,
//         ),
//       ),
//       // Show epub document
//       body: EpubView(
//         controller: _epubController,
//       ),
//     );
//   }
//
//
//
// }
