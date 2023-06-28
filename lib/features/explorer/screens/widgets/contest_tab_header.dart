import 'package:flutter/material.dart';

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader({required this.ui, this.max, this.min});

  final Widget ui;
  final double? max;
  final double? min;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ui;
  }

  @override
  double get maxExtent => max ?? 52;

  @override
  double get minExtent => min ?? 52;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
