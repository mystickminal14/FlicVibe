
import 'package:flick/pages/customer/customer_dashboard.dart';
import 'package:flick/pages/customer/my_account.dart';
import 'package:flick/pages/customer/my_order.dart';
import 'package:flick/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/user.dart';

class BottomNavigation extends StatefulWidget {
  final int index;
  const BottomNavigation({super.key, required this.index});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int pageIndex;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    List screenList = [
      const CustomerDashboard(),
      const MyOrder(),
      const MyAccount(),

    ];

    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xff1C1C2E),
        ),
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          iconSize: 30,
          type: BottomNavigationBarType.shifting,
          currentIndex: pageIndex,
          backgroundColor: const Color(0xff1C1C2E),
          selectedItemColor: Colors.white, // Selected item color
          unselectedItemColor: const Color(0xFF6B7380), // Unselected item color
          items: const [
            BottomNavigationBarItem(
              icon:Icon(Icons.home_filled),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.movie),
              label: "My Movies",
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.account_box),
              label: "My Account",
            ),

          ],
        ),
      ),
      body: screenList[pageIndex],
    );
  }
}
