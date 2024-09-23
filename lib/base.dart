import 'package:babyshieldx/calendar.dart';
import 'package:babyshieldx/homepage.dart';
import 'package:flutter/material.dart';

class TabBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              Container(child: HomePage()),
              Container(child: CalendarPage()),
              Container(child: Icon(Icons.directions_bike)),
              Container(child: Icon(Icons.directions_bike)),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Color(0xFF52C6A9),

      child: TabBar(
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.white70,

        dividerHeight: 0,
        labelPadding: EdgeInsets.only(top: 15,bottom: 5),
        tabs: [
          Tab(

            icon: Icon(Icons.home,size: 45,),
          ),
          Tab(
            icon: Icon(Icons.calendar_month,size : 45),
          ),
          Tab(
            icon: Icon(Icons.person,size : 45),
          ),
          Tab(
            icon: Icon(Icons.settings,size: 45,),
          ),
        ],
      ),
    );
  }
}