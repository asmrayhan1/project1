import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project1/components/logout_dialogue_box.dart';
import 'package:project1/view/screen/community.dart';
import 'package:project1/view/screen/user_auth/login_screen.dart';

import '../../controller/community/community_controller.dart';

class NewsFeed extends ConsumerStatefulWidget {
  const NewsFeed({super.key});

  @override
  ConsumerState<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends ConsumerState<NewsFeed> {

  int _selectedIndex = 0;
  void _onItemTapped(int index, BuildContext context) {
    if (index == 1){
      LogoutDialogBox.showDialogBox(context);
    } else {
      setState(() {
        _selectedIndex = index;
        print("index = ${index}");
      });
    }
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Community(),
    Text("data")
  ];

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((t){
      ref.read(communityController.notifier).getCommunityData();
    });

    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xff105866),
        leading: Icon(Icons.menu, color: Colors.white,),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Python Developer Community", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),),
            SizedBox(height: 3),
            Text("#General", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),),
          ],
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(20.0),child: Text(""),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex), backgroundColor: Color(0xffF5F5F5),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // This will keep track of the selected index
        onTap: (int index){
          _onItemTapped(index, context);
        }, // Function to handle tap events

        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xffF2f4f7),
        selectedItemColor: Color(0xff105866),
        unselectedItemColor: Colors.black87,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          color: Color(0xff105866),  // Change text color for the selected label
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.groups, size: 30,),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}
