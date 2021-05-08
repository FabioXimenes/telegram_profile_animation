import 'package:flutter/material.dart';

const double leftPadding = 20.0;
const double initialScrollOffset = 250.0;
const double maxHeaderExtent = 400.0;
const double scrollDesiredPercent = 0.65;
const Duration _duration = Duration(milliseconds: 100);

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
      duration: _duration,
      curve: Curves.linear,
    );
  }

  void animateToNormalExtent() {
    scrollController.animateTo(
      initialScrollOffset,
      duration: _duration,
      curve: Curves.linear,
    );
  }

  void _handleScrollingActivity() {
    if (!scrollController.position.isScrollingNotifier.value) {
      if (scrollController.offset >
              initialScrollOffset * scrollDesiredPercent &&
          scrollController.offset < initialScrollOffset) {
        animateToNormalExtent();
      } else if (scrollController.offset <
          initialScrollOffset * scrollDesiredPercent) {
        animateToMaxExtent();
      }
    } else {
      print('scroll is started');
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
            delegate: ProfileHeader(),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoWidget(),
                  Divider(
                    indent: leftPadding,
                    color: Colors.black,
                    thickness: 0.8,
                    height: 10,
                  ),
                  NotificationsWidget(),
                  ContainerDividerWidget(),
                  TabsWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

const double avatarRadius = 30;
const double minAvatarRadius = 20;
const double maxAvatarRadius = 50;

const double minLeftOffset = 20;
const double maxleftOffset = 80;

const double minTopOffset = 8;
const double maxTopOffset = 50;

const double minFontSize = 16;
const double maxFontSize = 18;

class ProfileHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final paddingTop = MediaQuery.of(context).padding.top;
    double percent = (shrinkOffset - initialScrollOffset) /
        (maxExtent - initialScrollOffset - paddingTop - 60);

    double radius = avatarRadius * (1 - percent);
    radius = radius.clamp(minAvatarRadius, maxAvatarRadius);

    double leftOffset = maxleftOffset * 1.3 * percent;
    leftOffset = leftOffset.clamp(minLeftOffset, maxleftOffset);

    double topOffset = maxTopOffset * (1 - percent);
    topOffset = topOffset.clamp(minTopOffset, maxTopOffset);

    double fontSize = maxFontSize * 3 * (1 - percent);
    fontSize = fontSize.clamp(minFontSize, maxFontSize);

    bool mustExpand = shrinkOffset < initialScrollOffset * scrollDesiredPercent;

    return Container(
      color: Colors.grey[900],
      child: Stack(
        children: [
          Positioned(
            top: 5 + paddingTop,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  Expanded(child: SizedBox()),
                  IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: _duration,
            top: mustExpand ? 0 : paddingTop + topOffset,
            left: mustExpand ? 0 : leftOffset,
            child: AnimatedContainer(
              duration: _duration,
              height: mustExpand ? maxExtent - shrinkOffset : 2 * radius,
              width:
                  mustExpand ? MediaQuery.of(context).size.width : 2 * radius,
              decoration: BoxDecoration(
                // color: Colors.red,
                shape:
                    shrinkOffset < 160 ? BoxShape.rectangle : BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/profile_picture.jpg'),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: _duration,
            top: mustExpand
                ? (maxExtent - shrinkOffset) - 60
                : percent > 0.9
                    ? paddingTop + 8
                    : paddingTop + topOffset + radius / 2 - 7,
            left: mustExpand ? 10 : leftOffset + 2 * radius + 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                    child: Text(
                      'Fábio Ximenes',
                    ),
                    style: TextStyle(
                      fontSize: shrinkOffset <
                              initialScrollOffset * (scrollDesiredPercent - 0.2)
                          ? 24
                          : fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                    duration: Duration(
                      milliseconds: 200,
                    )),
                SizedBox(height: 5),
                Text(
                  'Last seen recently',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderExtent;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

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

class ContainerDividerWidget extends StatelessWidget {
  const ContainerDividerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: double.infinity,
      color: Colors.black.withOpacity(0.65),
    );
  }
}

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({
    Key key,
  }) : super(key: key);

  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  bool isOn = false;

  void setNotificationsState(bool value) {
    setState(() {
      isOn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: leftPadding,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  isOn ? 'On' : 'Off',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            Switch(
              value: isOn,
              onChanged: setNotificationsState,
              activeColor: Colors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: leftPadding, right: leftPadding, top: 10),
              child: Text(
                'Info',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: leftPadding, vertical: 10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '+00 (00) 00000-0000',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Mobile',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
