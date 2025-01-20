// ignore_for_file: unnecessary_import, unused_import

import 'package:bganalysis/page/MyDrawarCard.dart';

import 'package:bganalysis/page/saleInvoiceReport.dart';

import 'package:bganalysis/provider/salesProvider.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../databaseFunction.dart';
import '../globalVariables.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? frimList = []; // list3;
  SalesProvider providerSales = new SalesProvider();
  int pageIndex = 0;
  final pages = [
    HomePage(),
  ];
  @override
  void initState() {
    super.initState();
    getDataSharedPreferences();
  }

  @override
  void dispose() {
    // Dispose any resources if necessary
    super.dispose();
  }

  getDataSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appKeyCodeGlobal = prefs.getString('appKeyCode').toString();
    firmCodeGlobal = prefs.getString('Firm_Code').toString();
    firmNameGlobal = prefs.getString('Firm_Name').toString();
    firmCiryGlobal = prefs.getString('City').toString();
    firmAddressGlobal = prefs.getString('Address').toString();
    firmGSTGlobal = prefs.getString('GST_NO').toString();
    firmMobile1Global = prefs.getString('Mobile_No1').toString();
    firmMobile2Global = prefs.getString('Mobile_No2').toString();
    firmEmailGlobal = prefs.getString('Email').toString();
    fetchFrimDetails();
  }

  void fetchFrimDetails() async {
    frimList = await getFirmDetails();
    if (kIsWeb) {
      providerSales.getDataGridViewSettingByProvider();
    } else {}

    if (!mounted) return;
    await providerSales.gstVatConfigSetByProvider(context);

    if (!mounted) return;
    // gstVatConfigSeetingInitialize();
    setState(() {});
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(firmNameGlobal,
          style: TextStyle(
            fontSize: 14,
          )),
      actions: [
        PopupMenuButton<String>(
          child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.more_vert,
                size: 31,
              )),
          itemBuilder: (context) => frimList!
              .map((item) => PopupMenuItem<String>(
                    value: item["Firm_Code"].toString(),
                    child: Text(
                      item["Firm_Name"].toString(),
                    ),
                  ))
              .toList(),
          onSelected: (value) {
            setDataFirmCodeGlobal(value, frimList!);
            print("Frim Code print..." + firmCodeGlobal);
            getDataSharedPreferences();
            setState(() {});
          },
        )
      ],
    );
  }

  SliverChildListDelegate _buildCommanDesign(
      double screenWidth, double screenHeight) {
    return SliverChildListDelegate(
      [
        Container(
          child: InkWell(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SaleInvoiceSaleReport()),
              )
            },
            child: Card(
              elevation: 3,
              child: GridTileBar(
                  title: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/1313000.png',
                        width: screenWidth * 0.35,
                        height: screenHeight * 0.07,
                      ),
                    ),
                  ),
                  subtitle: Center(
                      child: Text(
                    'Sales \n Report',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ))),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileView() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GridView.custom(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      childrenDelegate: _buildCommanDesign(screenWidth, screenHeight),
    );
  }

  Widget _buildWebView() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GridView.custom(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
      ),
      childrenDelegate: _buildCommanDesign(screenWidth, screenHeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: MyDrawarCard(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          if (maxWidth < 900) {
            return _buildMobileView();
          } else {
            return _buildWebView();
          }
        },
      ),
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  BottomNavigationBar buildMyNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 3,
      selectedFontSize: 15,
      unselectedFontSize: 15,
      currentIndex: pageIndex,
      onTap: onTabTapped,
      unselectedItemColor: Colors.black54,
      selectedItemColor: Colors.black,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: ImageIcon(
            AssetImage('assets/1313000.png'),
          ),
          label: 'Sale',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: ImageIcon(
            AssetImage('assets/purchase3.png'),
          ),
          label: 'Purchase',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: ImageIcon(
            AssetImage('assets/report.png'),
          ),
          label: 'Reports',
        ),
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      pageIndex = index;
      if (pageIndex == 0) {
        print(pageIndex);
      } else if (pageIndex == 1) {
      } else if (pageIndex == 2) {
      } else if (pageIndex == 3) {
        print(pageIndex);
      }
    });
  }
}
