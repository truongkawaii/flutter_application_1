import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateTaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Create New Task'),
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () => context.pop(),
      ),
    );
  }
}
