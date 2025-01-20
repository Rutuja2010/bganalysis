import 'dart:convert';

import 'package:bganalysis/commonWidgets/arithmeticClass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'error_handling.dart';
import 'globalVariables.dart';

ArithmeticClass arithmeticClass = ArithmeticClass();
String uRL = 'https://businessguruerp.com/';

Future getFirmDetails() async {
  List? firmDetailsList = [];

  String url = uRL + "" + "BG_API_NEW/FIRM_DETAILS.php";
  http.Response response = await http.post(Uri.parse(url), headers: {
    "Accept": "application/json"
  }, body: <String, String>{
    'appKeyCode': appKeyCodeGlobal,
  });

  // list = jsonDecode(response.body);
  firmDetailsList = jsonDecode(response.body);

  return firmDetailsList;
}

Future getSalesMTR(String fromDate, String toDate, String ledgerCode) async {
  List? salesMTRList = [];
  String url = uRL + "" + "BG_API_NEW/S_MTR_DISPLAY.php";
  http.Response? response = await http.post(Uri.parse(url), headers: {
    "Accept": "application/json"
  }, body: <String, String>{
    'appKeyCodeKey': appKeyCodeGlobal,
    'firmCodeKey': firmCodeGlobal,
    'custCode': ledgerCode,
    'fromDate': fromDate,
    'toDate': toDate,
  });

  if (response.body.isNotEmpty) {
    salesMTRList = jsonDecode(response.body);
  }
  return salesMTRList;
}

Future getSalesItemReport(String invoiceNo) async {
  List saleItemList = [];
  String url = uRL + "" + "BG_API_NEW/S_DTL_DISPLAY.php";
  http.Response? response = await http.post(Uri.parse(url), headers: {
    "Accept": "application/json"
  }, body: <String, String>{
    'appKeyCodeKey': appKeyCodeGlobal,
    'firmCodeKey': firmCodeGlobal,
    'invoiceNoKey': invoiceNo,
  });
  if (response.body.isNotEmpty) {
    saleItemList = jsonDecode(response.body);
  }

  return saleItemList;
}

Future getAllProductstockList(
    BuildContext context, String appKeyCodeKey, String firmCodeKey) async {
  List? purchaseItemList = [];
  String url = uRL + "" + "BG_API_NEW/PRODUCT_STOCK_DISPLAY.php";
  http.Response? response = await http.post(Uri.parse(url), headers: {
    "Accept": "application/json"
  }, body: <String, String>{
    'appKeyCodeKey': appKeyCodeKey, //appKeyCodeGlobal,
    'firmCodeKey': firmCodeKey, //firmCodeGlobal,
  });

  httpErrorHandle(
    response: response,
    context: context,
    onSuccess: () {
      purchaseItemList = jsonDecode(response.body);
    },
  );
  return purchaseItemList;
}

Future getGroupList(
    BuildContext context, String appKeyCodeKey, String firmCodeKey) async {
  List? groupList = [];

  String url = uRL + "" + "BG_API_NEW/PRODUCT_GROUP_DISPLAY.php";
  http.Response? response = await http.post(Uri.parse(url), headers: {
    "Accept": "application/json"
  }, body: <String, String>{
    'appKeyCodeKey': appKeyCodeKey,
    'firmCodeKey': firmCodeKey,
  });

  httpErrorHandle(
    response: response,
    context: context,
    onSuccess: () {
      groupList = jsonDecode(response.body);
    },
  );
  return groupList;
}

Future getGSTVATConfig(BuildContext context, String operation, String valuee,
    String printType) async {
  List<Map<String, String>> jsonMeeting = [
    {
      "Operation": operation,
      "appKeyCodeKey": appKeyCodeGlobal,
      "Valuee": valuee,
      "Print_Type": printType,
    }
  ];
  List? gstVatConfing = [];

  String url = uRL + "" + "BG_API_NEW/GST_VAT_CONFIG_DISPLAY.php";
  http.Response response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: json.encode(jsonMeeting),
  );

  httpErrorHandle(
    response: response,
    context: context,
    onSuccess: () {
      if (operation == "Display_Operation") {
        gstVatConfing = jsonDecode(response.body);
      }
    },
  );

  return gstVatConfing;
}

Future getDataGridViewSetting(String operation, String columnReadonly,
    String fieldName, String frmName) async {
  List dataGridView = [];
  List<Map<String, String>> postDataDataGrid = [
    {
      "appKeyCodeKey": appKeyCodeGlobal,
      "FirmCodekey": firmCodeGlobal,
      "Column_Readonly": columnReadonly,
      "Field_Name": fieldName,
      "FrmName": frmName,
      "Operation": operation
    }
  ];

  String url = uRL + "" + "BG_API_NEW/Data_GridConfig.php";
  http.Response? responseProductTaxList = await http.post(
    Uri.parse(url),
    headers: {"Accept": "application/json"},
    body: jsonEncode(postDataDataGrid),
  );

  if (responseProductTaxList.body.isNotEmpty) {
    if (operation == "Display_Operation") {
      dataGridView = jsonDecode(responseProductTaxList.body);
    }
  }

  return dataGridView;
}

Future printConfig(String operation, String hide, String fieldName) async {
  List<Map<String, String>> jsonMeeting = [
    {
      "Operation": operation,
      "Form_Name": "Print__A4_Size_GST_Invoice",
      "Field_Name": fieldName,
      "Hide": hide,
      "Firm_Code": firmCodeGlobal,
      "APP_KEY_CODE": appKeyCodeGlobal
    }
  ];
  List? printConfig = [];

  String url = uRL + "" + "BG_API_NEW/PRINT_CONFIG_SETTINGS.php";

  http.Response response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: json.encode(jsonMeeting),
  );

  if (response.body.isNotEmpty) {
    if (operation == "Display_Operation") {
      printConfig = jsonDecode(response.body);
    }
  }
  return printConfig;
}
