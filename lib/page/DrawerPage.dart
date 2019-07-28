import 'package:flutter/material.dart';

import 'AboutPage.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          new Container(
            height: 250.0,
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 48.0, 8.0, 48.0),
              child: new Center(
                child: CircleAvatar(
                  maxRadius: 48.0,
                  minRadius: 32.0,
                  child: Text("W"),
                ),
              ),
            ),
          ),
          new Divider(),
          new ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "About",
                style: TextStyle(fontSize: 16.0),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new AboutPage()),
                );
              }),
        ],
      ),
    );
  }
}
