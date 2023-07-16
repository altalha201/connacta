import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../screens/logged_in/home_tabs/chat_list_tab.dart';
import '../../screens/logged_in/home_tabs/people_list_tab.dart';
import '../../screens/logged_in/home_tabs/story_tab.dart';

class HomeScreenController extends GetxController {
  int _currentTabIndex = 0;
  String _title = "Chats";
  Widget _currentTab = const ChatListTab();

  final _tabs = [
    const ChatListTab(),
    const PeopleListTab(),
    const StoryTab()
  ];

  final _titles = ["Chats", "People", "Stories"];

  int get currentTabIndex => _currentTabIndex;
  String get title => _title;
  Widget get currentTab => _currentTab;

  void updateTab(int index) {
    _currentTabIndex = index;
    _title = _titles[_currentTabIndex];
    _currentTab = _tabs[_currentTabIndex];
    update();
  }

  void resetHome() {
    updateTab(0);
  }
}