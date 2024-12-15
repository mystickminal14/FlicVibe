
import 'package:flick/pages/add-page.dart';
import 'package:flick/pages/admin_acc.dart';
import 'package:flick/pages/homepage.dart';
import 'package:flick/pages/orderDetails.dart';
import 'package:flick/pages/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/user.dart';

class AdminNavi extends StatefulWidget {
  final int index;
  const AdminNavi({super.key, required this.index});

  @override
  State<AdminNavi> createState() => _AdminNaviState();
}

class _AdminNaviState extends State<AdminNavi> {
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
      const Homepage(),
      const OrderDetails(),
      const AddMovie(),
      const AdminAccount(),
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
              icon:Icon(Icons.movie),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.movie),
              label: "Orders"
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.add),
              label: "Add Movies",
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.account_balance),
              label: "Account",
            ),
          ],
        ),
      ),
      body: screenList[pageIndex],
    );
  }
}
