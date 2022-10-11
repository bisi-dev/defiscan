import 'package:flutter/material.dart';

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader({required this.ui, required this.max, required this.min});

  final Widget ui;
  final double max;
  final double min;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ui;
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
