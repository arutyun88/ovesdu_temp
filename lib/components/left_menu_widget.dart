import 'package:flutter/material.dart';
import 'package:ovesdu/components/theme_change_button.dart';

class LeftMenu extends StatefulWidget {
  const LeftMenu({Key key}) : super(key: key);

  @override
  _LeftMenuState createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 200,
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://animalreader.ru/wp-content/uploads/2014/10/sus-scrofa-e1413736415314-1024x841.jpg"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Arutyun Gevorkyan',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ThemeChangeButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
