import 'package:flutter/material.dart';

class DeFiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DeFiAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
      ),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context, 0);
        },
      ),
    );
  }
}
