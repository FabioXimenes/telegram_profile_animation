import 'package:flutter/material.dart';

import 'components/container_divider_widget.dart';
import 'components/custom_grid_widget.dart';
import 'components/notifications_widget.dart';
import 'components/profile_info_widget.dart';
import 'components/persistent_profile_header.dart';
import 'components/persistent_tabs_widget.dart';

const double leftPadding = 20.0;
const double initialScrollOffset = 250.0;
const double scrollDesiredPercent = 0.65;
const Duration duration = Duration(milliseconds: 100);

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: initialScrollOffset);

  void animateToMaxExtent() {
    scrollController.animateTo(
      50,
      duration: duration,
      curve: Curves.linear,
    );
  }

  void animateToNormalExtent() {
    scrollController.animateTo(
      initialScrollOffset,
      duration: duration,
      curve: Curves.linear,
    );
  }

  bool get scrollStopped =>
      !scrollController.position.isScrollingNotifier.value;

  bool get mustExpand =>
      scrollController.offset < initialScrollOffset * scrollDesiredPercent;

  bool get mustRetract =>
      !mustExpand && scrollController.offset < initialScrollOffset;

  void _handleScrollingActivity() {
    if (scrollStopped) {
      if (mustRetract) {
        animateToNormalExtent();
      } else if (mustExpand) {
        animateToMaxExtent();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.position.isScrollingNotifier
          .addListener(_handleScrollingActivity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPersistentHeader(
            delegate: PersistentProfileHeader(),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileInfoWidget(),
                  Divider(
                    indent: leftPadding,
                    color: Colors.black,
                    thickness: 0.8,
                    height: 10,
                  ),
                  NotificationsWidget(),
                  ContainerDividerWidget(),
                ],
              ),
            ),
          ),
          PersistentTabsWidget(),
          CustomGridWidget(),
        ],
      ),
    );
  }
}
