import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pppcalculator/constants.dart' as Constants;
import 'package:pppcalculator/controller/data_controller.dart';

import 'package:pppcalculator/view/screens/calculator/about.dart';

class DrawerMenuWidget extends StatefulWidget {
  const DrawerMenuWidget({super.key});

  @override
  State<DrawerMenuWidget> createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/1024.png"),
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
              DataController.instance.goToHome();
            },
          ),
          ListTile(
            title: const Text('About'),
            selected: _selectedIndex == 1,
            onTap: () {
              DataController.instance.goToAbout();
            },
          ),
          ListTile(
            title: const Text('Exit'),
            selected: _selectedIndex == 2,
            onTap: () => dropOut(context),
          ),
        ],
      ),
    );
  }
}
