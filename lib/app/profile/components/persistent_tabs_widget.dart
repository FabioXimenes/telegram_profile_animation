import 'package:flutter/material.dart';

import '../profile_page.dart';

class PersistentTabsWidget extends StatefulWidget {
  const PersistentTabsWidget({
    Key key,
  }) : super(key: key);

  @override
  _PersistentTabsWidgetState createState() => _PersistentTabsWidgetState();
}

class _PersistentTabsWidgetState extends State<PersistentTabsWidget>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  final List<Tab> tabs = [
    Tab(text: 'Media'),
    Tab(text: 'Links'),
    Tab(text: 'Voice'),
    Tab(text: 'GIFs'),
    Tab(text: 'Groups'),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 25,
      flexibleSpace: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: leftPadding),
            child: TabBar(
              controller: tabController,
              labelPadding: const EdgeInsets.symmetric(horizontal: 5),
              indicatorColor: Colors.lightBlue,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.lightBlue,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: tabs,
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 0.8,
            height: 1,
          ),
        ],
      ),
    );
  }
}
