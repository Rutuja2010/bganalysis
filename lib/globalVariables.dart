import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

String appKeyCodeGlobal = "";
String firmCodeGlobal = "";
String firmNameGlobal = "";
String firmAddressGlobal = "";
String firmGSTGlobal = "";
String firmCiryGlobal = "";
String firmMobile1Global = "";
String firmMobile2Global = "";
String firmEmailGlobal = "";

String checkNet = "false";
List dataGridViewGlobal = [];
List printConfigGlobal = [];
late String productSelectTypeOption;
late String selectGSTOption;
late String salesGstInOutOption;
late String purchaseGstInOutOption;
late String saleConvertFromOption;
late String saleConvertToOption;
late String purchaseConvertFromOption;
late String purchaseConvertToOption;
late String purchaseDiscountInBill;
late String saleDiscountInBill;
late String groupWiseProductName;
late String productMasterCallFlag = "PRODUCTADD";

setDataFirmCodeGlobal(String getfirmcode, List filterList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("Firm_Code", getfirmcode);

  filterList
      .map(
        (mapValue) => mapValue['Firm_Code'].toString() == getfirmcode
            ? (
                prefs.setString("City", mapValue['City'].toString()),
                prefs.setString("Address", mapValue['Address'].toString()),
                prefs.setString("GST_NO", mapValue['GST_NO'].toString()),
                prefs.setString("Email", mapValue['Email'].toString()),
                prefs.setString(
                    "Mobile_No1", mapValue['Mobile_No1'].toString()),
                prefs.setString(
                    "Mobile_No2", mapValue['Mobile_No2'].toString()),
                prefs.setString("Firm_Name", mapValue['Firm_Name'].toString())
              )
            : "",
      )
      .toList();

  firmCodeGlobal = getfirmcode;
  print(firmCiryGlobal);
}

getDataFirmCodeGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  firmCodeGlobal = prefs.getString('Firm_Code').toString();
}

getDatAppKeyCodeGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  appKeyCodeGlobal = prefs.getString('appKeyCode').toString();
}

checkNetConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    checkNet = "true";
  } else {
    checkNet = "false";
  }
}

gstVatConfigSeetingInitialize() {
  selectGSTOption = 'GST';
  salesGstInOutOption = 'GST OUT';
  purchaseGstInOutOption = 'GST OUT';
  productSelectTypeOption = "ProductWise";
  saleConvertFromOption = "INCH";
  saleConvertToOption = "SQFT";
  purchaseConvertFromOption = "INCH";
  purchaseConvertToOption = "SQFT";
  purchaseDiscountInBill = "OUTDISCOUNT";
  saleDiscountInBill = "OUTDISCOUNT";
  groupWiseProductName = "NO";
}
