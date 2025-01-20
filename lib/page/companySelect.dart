import 'package:bganalysis/databaseFunction.dart';
import 'package:bganalysis/globalVariables.dart';
import 'package:bganalysis/loadding.dart';

import 'package:bganalysis/page/homePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanySelect extends StatefulWidget {
  const CompanySelect({super.key});

  @override
  State<CompanySelect> createState() => _CompanySelectState();
}

class _CompanySelectState extends State<CompanySelect> {
  List? frimList = []; // list3;

  @override
  void initState() {
    super.initState();
    getDataSharedPreferences();
    //fetchFrimDetails();
  }

  @override
  void dispose() {
    if (frimList != null) {
      frimList!.clear();
    }
    super.dispose();
  }

  void fetchFrimDetails() async {
    frimList = await getFirmDetails();
    setState(() {});
  }

  getDataSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appKeyCodeGlobal = prefs.getString('appKeyCode').toString();
    firmCodeGlobal = prefs.getString('Firm_Code').toString();
    firmNameGlobal = prefs.getString('Firm_Name').toString();
    firmCiryGlobal = prefs.getString('City').toString();
    firmAddressGlobal = prefs.getString('Address').toString();
    firmGSTGlobal = prefs.getString('GST_NO').toString();
    fetchFrimDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company List'),
        automaticallyImplyLeading: false,
      ),
      //drawer: MyDrawarCard(),
      body: frimList?.isNotEmpty == true
          ? ledgerListView()
          : Center(
              child: Loadding(),
            ),
    );
  }

  ListView ledgerListView() {
    return ListView.builder(
      itemCount: frimList!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ledgerCardLayout(index);
      },
    );
  }

  Card ledgerCardLayout(int index) {
    return Card(
      elevation: 1,
      child: ledgerListTileLayout(index),
    );
  }

  ListTile ledgerListTileLayout(int index) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            frimList![index]["Firm_Name"].toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            frimList![index]["Address"].toString(),
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            frimList![index]["GST_NO"].toString(),
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
      onTap: () {
        setDataFirmCodeGlobal(
            frimList![index]["Firm_Code"].toString(), frimList!);
        print("Frim Code print..." + firmCodeGlobal);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    );
  }
}
