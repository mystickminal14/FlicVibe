
import 'package:flick/pages/navigation/admin_nav.dart';
import 'package:flick/pages/navigation/bottom_navigation.dart';
import 'package:flick/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/user.dart';

class Authorize extends StatefulWidget {
  const Authorize({super.key});

  @override
  State<Authorize> createState() => _AuthorizeState();
}

class _AuthorizeState extends State<Authorize> {
  bool _isLoad = true;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);


    if (_isLoad) {
      _isLoad = false;
    }

    if (!_isLoad) {
      if (user?.role == 'admin') {
        return const AdminNavi(index: 1);
      } else if (user?.role == 'customer') {
        return const BottomNavigation(index: 0);
      } else {
        return const WelcomePage();
      }
    }

    return const CircularProgressIndicator();
  }
}
