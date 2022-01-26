import 'package:a_ecomerce/tabs/home_tab.dart';
import 'package:a_ecomerce/tabs/saved_tab.dart';
import 'package:a_ecomerce/tabs/search_tab.dart';
import 'package:a_ecomerce/widgets/botton_tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class HomePage extends StatefulWidget {

  @override
  _Homepage createState() => _Homepage();
}

class _Homepage extends State<HomePage> {
  late PageController _tabsPagesController;

  @override
  void initState(){
    _tabsPagesController = PageController();
    super.initState();
  }
  void dispose(){
    _tabsPagesController.dispose();
    super.dispose();
  }

  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPagesController,
              onPageChanged: (num){
                setState(() {
                   _selectedTab = num;
                   print(_selectedTab);
                 });
              },
                children:[
              HomeTab(),
              SearchTab(),
             SavedTab()
           ]
            ),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              setState(() {
                _tabsPagesController.animateToPage(num, duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic);
              });
            },
          )

        ],
      )
    );
  }
}

