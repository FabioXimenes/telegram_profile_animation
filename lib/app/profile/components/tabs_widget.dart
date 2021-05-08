import 'package:flutter/material.dart';

import '../profile_page.dart';

class TabsWidget extends StatefulWidget {
  const TabsWidget({
    Key key,
  }) : super(key: key);

  @override
  _TabsWidgetState createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget>
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: leftPadding),
          height: 50,
          child: TabBar(
            controller: tabController,
            labelPadding: const EdgeInsets.symmetric(horizontal: 5),
            indicatorColor: Colors.lightBlue,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.lightBlue,
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: tabs,
          ),
        ),
        Divider(
          color: Colors.black,
          thickness: 0.8,
          height: 1,
        ),
        Container(
          height: MediaQuery.of(context).size.height,
        ),
      ],
    );
  }
}
