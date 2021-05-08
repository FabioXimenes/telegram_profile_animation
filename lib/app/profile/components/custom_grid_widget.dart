import 'package:flutter/material.dart';

class CustomGridWidget extends StatelessWidget {
  const CustomGridWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          return Container(
            color: Colors.cyan[100 * (index % 9)],
          );
        },
        childCount: 20,
      ),
    );
  }
}
