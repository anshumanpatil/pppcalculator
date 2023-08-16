import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pppcalculator/constants.dart' as Constants;

import 'package:pppcalculator/view/screens/aboutus/about.dart';
import 'package:pppcalculator/view/screens/calculator/calculator.dart';

class DrawerMenuWidget extends StatefulWidget {
  const DrawerMenuWidget({super.key});

  @override
  State<DrawerMenuWidget> createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {
  var imageAsset;

  @override
  void initState() {
    super.initState();

    imageAsset = AssetImage("assets/images/1024.png");
  }


  int _selectedIndex = 0;
  Future<String?> dropOut(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('PPP Calculator'),
        content: const Text('Do You want to exit ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              SystemNavigator.pop();
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageAsset,
                fit: BoxFit.fitWidth,
              ),
              color: Colors.black,
            ),
            child: Container(
              alignment: Alignment.bottomLeft,
              height: 10,
              child: const Text(Constants.APP_TITLE),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            selected: _selectedIndex == 0,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Calculator()),
              );

            },
          ),
          ListTile(
            title: const Text('About'),
            selected: _selectedIndex == 1,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );

            },
          ),
          ListTile(
            title: const Text('Exit'),
            selected: _selectedIndex == 2,
            onTap: () => AwesomeDialog(
    context: context,
    dialogType: DialogType.info,
    animType: AnimType.rightSlide,
    title: 'PPP Calculator',
    desc: 'Do You want to exit ?',
    btnCancelOnPress: () {

    },
    btnOkOnPress: () {
      Navigator.pop(context);
      SystemNavigator.pop();
    },
    )..show()
    ,
          ),
        ],
      ),
    );
  }
}
