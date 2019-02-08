import 'package:flutter/material.dart';

//importing other pages
import './home.0.dart';
import './home.1.dart';
import './barcode_scanner.dart';
import './home.3.dart';
import './home.4.dart';



class HomeScreen extends StatefulWidget {
  final String uid = "";
  HomeScreen({Key key, @required uid}) : super(key: key);
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  // we create a variable for the selected page and we updated in the onTap method
  int _selectedPage = 0;
  // we create an array that contains all pages that could be accessed by the navigation bar
  final _pageOptions = [
    HomePage0(),
    HomePage1(),
    HomePage1(),
    HomePage3(),
    HomePage4(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.amber,
          // the type should be fixed to make navbar colors appear, bcz of a bug when we have 3 navbars and more.
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              // here the variable of the selected page is updated when we press on the navigation bar button
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.work), title: Text('Work')),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt), title: Text('Barcode')),
            BottomNavigationBarItem(
                icon: Icon(Icons.label), title: Text('Label')),
            BottomNavigationBarItem(icon: Icon(Icons.tab), title: Text('Tab')),
          ],
        ),
      ),
    );
  }
}
