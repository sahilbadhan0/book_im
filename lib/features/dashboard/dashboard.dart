import 'package:book_im/features/author/bloc/demo_bloc.dart';
import 'package:book_im/features/author/data/event_repository.dart';
import 'package:book_im/features/author/ui/author_list_screen.dart';
import 'package:book_im/features/category/bloc/demo_bloc.dart';
import 'package:book_im/features/category/data/event_repository.dart';
import 'package:book_im/features/category/ui/category_tab.dart';
import 'package:book_im/features/home/HomeScreen.dart';
import 'package:book_im/utils/AssetStrings.dart';
import 'package:book_im/utils/reusableWidgets/customBottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  //getters
  get getBottomNavigation {
    return CustomBottomBar(
      controller: tabController,
      items: [
        NavigationBarItem(
          icon: Icons.menu,
          title: "Home",
        ),
        NavigationBarItem(
          icon: Icons.bar_chart,
          title: "PrayerBoard",
        ),
        NavigationBarItem(
          icon: Icons.person,
          title: "My Daily Prayer",
        ),
        NavigationBarItem(
          icon: Icons.settings,
          title: "Event",
        ),
      ],
    );
  }

  //
  get getTabBarView {
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          HomeScreen(),
          BlocProvider(
            create: (BuildContext context) =>
                CategoryBloc(eventRepository: CategoryRepository()),
            child: CategoryTab(),
          ),
          BlocProvider(
            create: (BuildContext context) =>
                AuthorBloc(eventRepository: AuthorRepository()),
            child: AuthorScreen(),
          ),

          Container(),

//          Home(),
//          HomeScreen(),
//          Menu(),
//          FavoriteScreen(
//            navigateToIndex: moveToScreen,
//          ),
//          CartScreen(
//            navigateToIndex: moveToScreen,
//          ),
//          Account(),
        ]);
  }

  moveToScreen(int index) {
    tabController.animateTo(index, duration: Duration(milliseconds: 100));
    setState(() {});
  }

  //State management

  @override
  void initState() {
    tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getTabBarView,
      bottomNavigationBar: getBottomNavigation,
    );
  }
}
