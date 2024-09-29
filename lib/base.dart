import 'package:babyshieldx/calendar.dart';
import 'package:babyshieldx/homepage.dart';
import 'package:babyshieldx/manage_children.dart';
import 'package:babyshieldx/settings.dart';
import 'package:flutter/material.dart';

class TabBase extends StatefulWidget {
  final int initialIndex;

  TabBase({this.initialIndex = 0});

  @override
  _TabBaseState createState() => _TabBaseState();
}

class _TabBaseState extends State<TabBase> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4, // Number of tabs
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void changeTab(int index) {
    setState(() {
      _tabController?.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: MaterialApp(
      home: Scaffold(
        bottomNavigationBar: menu(),
        body: TabBarView(
          controller: _tabController,
          children: [
            HomePage(changeTab: changeTab), // Passing changeTab to HomePage
            CalendarPage(),
            ManageChildrenPage(),
            SettingsPage(),
          ],
        ),
      ),
    ));
  }

  Widget menu() {
    return Container(

      color: Color(0xFF52C6A9),
      child: TabBar(
        dividerHeight: 0,
        controller: _tabController,
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.white70,
        padding: EdgeInsets.only(top: 10,bottom: 10),
        tabs: [
          Tab(icon: Icon(Icons.home, size: 45)),
          Tab(icon: Icon(Icons.calendar_month, size: 45)),
          Tab(icon: Icon(Icons.person, size: 45)),
          Tab(icon: Icon(Icons.settings, size: 45)),
        ],
      ),
    );
  }
}
