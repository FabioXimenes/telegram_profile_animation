import 'package:flutter/material.dart';

import '../profile_page.dart';

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
