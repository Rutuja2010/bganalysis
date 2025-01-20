import 'dart:convert';

import 'package:bganalysis/page/MyDrawarCard.dart';
import 'package:bganalysis/page/companySelect.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

// ignore: camel_case_types
class _loginPageState extends State<loginPage> {
  TextEditingController _controllerAppKey = new TextEditingController();
  TextEditingController _controllerMobileNo = new TextEditingController();

  addStringToSF() async {
    String loginStstus = await loginFuction();

    if (loginStstus == "True") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('appKeyCode', _controllerAppKey.text.toString());
      prefs.setString("Firm_Code", "3");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CompanySelect()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("AppKey Code or Mobile Wrong. Plz Check and try Agen"),
      ));
    }
  }

  Future loginFuction() async {
    List responseList = [];
    String url = "https://businessguruerp.com/BG_API_NEW/USER_LOGING.php";
    http.Response response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: <String, String>{
      'appKeyCode': _controllerAppKey.text.toString(),
      'Reg_MobileNo': _controllerMobileNo.text.toString(),
    });

    if (response.statusCode == 200) {
      responseList = json.decode(response.body);
      return responseList[0]["response"].toString();
    }

    //setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // addStringToSF();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerMobileNo.dispose();
    _controllerAppKey.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawarCard(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/bglogo.png')),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _controllerAppKey,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'App Key',
                    hintText: 'Enter App Key'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _controllerMobileNo,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile No.',
                    hintText: 'Enter Register Mobile No.'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 60,
              width: 380,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: OutlinedButton(
                child: Text("Login"),
                style: OutlinedButton.styleFrom(
                  // primary: Colors.amber,
                  side: BorderSide(
                    color: Colors.amber,
                  ),
                ),
                onPressed: () {
                  // print('js333');
                  addStringToSF();
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('New User? Create Account')
          ],
        ),
      ),
    );
  }
}
