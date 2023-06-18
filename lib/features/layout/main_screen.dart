import 'package:flutter/material.dart';
import 'package:ptt_rtmb/features/layout/home.dart';
import 'package:ptt_rtmb/core/utils/widgets/icon_badge.dart';
import 'package:ptt_rtmb/features/user_profile/profile_page.dart';
import 'package:ptt_rtmb/features/map/maps.dart';
import 'package:ptt_rtmb/core/constants/constants.dart';

import '../augmented_reality/bird_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: onPageChanged,
            children: buildChildren(),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Constants.tAppPrimaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(width: 7.0),
                barIcon(),
                barIcon(icon: Icons.app_shortcut_sharp, page: 1),
                barIcon(icon: Icons.map, page: 2),
                barIcon(icon: Icons.person, page: 3),
                const SizedBox(width: 7.0),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> buildChildren() {
    int index = _page;

    List<Widget> pageWidget = List.generate(1, (index) => const ProfilePage());

    switch (index) {
      case 0:
        pageWidget = List.generate(5, (index) => const Home());
        break;
      case 1:
        pageWidget = List.generate(
            5,
            (index) => const ARCore(
                  title: 'Guia Virtual',
                ));
        break;
      case 2:
        pageWidget = List.generate(5, (index) => const MapPage());
        break;
      case 3:
        pageWidget = List.generate(5, (index) => const ProfilePage());
        break;
    }

    return pageWidget;
  }

  Widget barIcon(
      {IconData icon = Icons.home, int page = 0, bool badge = false}) {
    return IconButton(
      icon: badge ? IconBadge(icon: icon, size: 24.0) : Icon(icon, size: 24.0),
      color: _page == page
          ? Theme.of(context).secondaryHeaderColor
          : const Color.fromARGB(255, 13, 14, 15),
      onPressed: () => {_pageController.jumpToPage(page), _page = page},
    );
  }
}
