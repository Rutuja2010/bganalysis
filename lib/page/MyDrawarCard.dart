import 'package:bganalysis/page/Tools/printConfig.dart';

import 'package:bganalysis/page/homePage.dart';
import 'package:bganalysis/page/loginPage.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawarCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        UserAccountsDrawerHeader(
          accountName: Text("Business Guru"),
          accountEmail: Text('7249887835'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text(
              '',
              style: TextStyle(fontSize: 23.00),
            ),
          ),
        ),
        ListTile(
          title: Text('Home'),
          leading: Icon(Icons.home_filled),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        ExpansionTile(
          title: Text('Tools'),
          leading: Icon(Icons.settings),
          children: [
            // Sublist item for "Sales Report"
            Padding(
              padding: EdgeInsets.only(
                  left: 55.0), // Adjust the left padding as needed
              child: ListTile(
                title: Text('Data GridView'),
                leading: Icon(Icons.table_chart),
                onTap: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 55.0), // Adjust the left padding as needed
              child: ListTile(
                title: Text('GST Config'),
                leading: Icon(Icons.settings_accessibility),
                onTap: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 55.0), // Adjust the left padding as needed
              child: ListTile(
                title: Text('Print Config'),
                leading: Icon(Icons.local_print_shop),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrintConfig()),
                  );
                },
              ),
            ),
          ],
        ),
        ListTile(
          title: Text('Logout'),
          leading: Icon(Icons.logout_outlined),
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('appKeyCode', "");
            prefs.setString('Firm_Code', "");

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => loginPage()),
            );
          },
        )
      ]),
    );
  }
}
